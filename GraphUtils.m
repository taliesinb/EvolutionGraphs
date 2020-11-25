Package["EvolutionGraphs`"]

PackageImport["GeneralUtilities`"]


Options[GraphToSuccessorAssociation] = {
  "IncludeSelf" -> False
};


PackageExport["GraphToSuccessorAssociation"]

SetUsage @ "
GraphToSuccessorAssociation[graph$, opts$] takes a graph$ and for each vertex returns the possible \
successors in an association based on the directionality of edges
"

GraphToSuccessorAssociation[graph_, OptionsPattern[]] := Scope[
  vertices = VertexList[graph];
  n = Length[vertices];
  adjacency = Normal @ AdjacencyMatrix[graph];
  If[OptionValue["IncludeSelf"], adjacency += IdentityMatrix[n]];
  association = <||>;
  Do[
    association[vertices[[i]]] = Pick[vertices, adjacency[[i]], 1],
    {i, n}
  ];
  association
];


PackageExport["SuccessorAssociationToGraph"]

SuccessorAssociationToGraph[assoc_, opts___] := Graph[
  Keys[assoc],
  Flatten[Function[{src, dsts}, Map[src -> #&, dsts]] @@@ Normal[assoc]],
  opts
];

SetUsage @ "
SuccessorAssociationToGraph[association$, opts$] takes an association$ and returns the graph where the \
edges are directed from the keys to the values.
"


PackageExport["GraphSignature"]

vectorAng[a_, b_] := Quiet @ Check[Round[Dot[a, b], 0.001], None];
GraphSignature[graph_] := Module[{adj,evecs},
  adj = WeightedAdjacencyMatrix[graph];
  evecs = N @ Eigenvectors[adj];
  evecs = Join[evecs, -evecs];
  {Eigenvalues[adj], Sort[vectorAng @@@ Subsets[evecs, {2}]],
    Length @ GraphSources @ graph,
    Length @ GraphSinks @ graph,
    GraphDiameter @ graph,
    GraphRadius @ graph,
    KeySort @ Counts[Flatten @ GraphDistanceMatrix @ graph]}
];

SetUsage @ "
GraphSignature[graph$] returns the number of a graphs$ sources and sinks, it's diameter, radius and the \
counts of the graph's$ distance matrix.
"


PackageExport["IsomorphicGraphRepresentatives"]

IsomorphicGraphRepresentatives[graphs_] :=
  First /@ Values[GroupBy[graphs, GraphSignature]];

SetUsage @ "
IsomorphicGraphRepresentatives[graphs$] checks for the graphs$ signatures, groups the similar ones and \
then only shows the first.
"