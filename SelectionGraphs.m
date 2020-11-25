Package["EvolutionGraphs`"]

PackageImport["GeneralUtilities`"]


SetUsage @ "
selectionSuccessorFunction[generationVector$, deletions$] takes a generation$ vector$ and a successor \
association which reflects the valid deletions$ and outputs the valid generation vector successors.
"

selectionSuccessorFunction[generationVector_, deletions_] := With[
  {n = Length[generationVector]},
  Map[
    If[!MemberQ[generationVector, #], Nothing,
      DeleteCases[generationVector, #]]&,
    Union @@ Lookup[deletions, generationVector]
  ]
];


PackageExport["SelectionGraph"]

SetUsage @ "
SelectionGraph[fitnessGraph$] translates the valid deletions, as represented in the fitness$ graph$ \
and shows the resulting valid generation level updates (selection).
"

SelectionGraph[fitnessGraph_] := Module[
  {genotypes, generationVectors, deletions, successorAssociation},
  genotypes = VertexList[fitnessGraph];
  generationVectors = Subsets[Sort @ genotypes, {1, Length[genotypes]}];
  deletions = GraphToSuccessorAssociation[ReverseGraph[fitnessGraph], "IncludeSelf" -> False];
  (* allowedMutants association maps a genotype to a list of distance \[LessEqual] 1 genotypes *)
  successorAssociation = AssociationMap[selectionSuccessorFunction[#, deletions]&, generationVectors];
  NiceGraph @ SuccessorAssociationToGraph[successorAssociation, Options[fitnessGraph]]
];

