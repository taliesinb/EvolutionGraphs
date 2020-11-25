Package["EvolutionGraphs`"]

PackageImport["GeneralUtilities`"]


PackageExport["AllDirectedGraphs"]

SetUsage @ "
AllDirectedGraphs[graph$] returns all possible variations of the graph$ where the edges can \
be undirected, not existent or directed towards either vertix.
"

AllDirectedGraphs[graph_] := Scope[
  edges = EdgeList[graph];
  verts = VertexList[graph];
  opts = Options[graph];
  n = Length[edges];
  edgeChoices = Function[{a, b}, {a -> b, b -> a, a <-> b, None}] @@@ edges;
  Graph[verts, DeleteNone[#], opts]& /@ Tuples[edgeChoices]
];
