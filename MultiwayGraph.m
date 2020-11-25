Package["EvolutionGraphs`"]

PackageImport["GeneralUtilities`"]


MultiwaySystem := ResourceFunction["MultiwaySystem"]

PackageExport["GraphPathMultiwaySystem"]

SetUsage @ "
GraphPathMultiwaySystem[graph$, args$, opts$] takes a graph$ and extends it such that in each \
row the vertices connect to all valid successors, as determined in the graph, in the row below.
"

Options[GraphPathMultiwaySystem] = {
  "IncludeStatePathWeights" -> False,
  VertexLabels -> None,
  "IncludeSelfMoves" -> True
};

GraphPathMultiwaySystem[graph_, All, args___, opts:OptionsPattern[]] :=
  GraphPathMultiwaySystem[graph, VertexList[graph], args, opts];

stepIdFixer[f_][sn_ -> state_] := Thread[(sn + 1) -> f[state]];

GraphPathMultiwaySystem[graph_, args___, opts:OptionsPattern[]] := Scope[
  UnpackOptions[includeSelfMoves];
  successorAssociation = GraphToSuccessorAssociation[graph, "IncludeSelf" -> includeSelfMoves];
  MultiwaySystem[<|
    "StateEvolutionFunction" -> stepIdFixer[successorAssociation],
    "StateEquivalenceFunction" -> SameQ,
    "StateEventFunction" -> Identity,
    "EventDecompositionFunction" -> Identity,
    "EventApplicationFunction" -> Identity,
    "SystemType" -> "StringSubstitutionSystem",
    "EventSelectionFunction" -> Identity|>,
    args,
    "IncludeStepNumber" -> True,
    opts
  ]
];

