Package["EvolutionGraphs`"]

PackageImport["GeneralUtilities`"]


niceEdgeShapeFunction[coords_, d_DirectedEdge] :=
  GraphElementData[{"ShortFilledArrow","ArrowSize"->.055}][coords, d];

niceEdgeShapeFunction[coords_, _] := Line[coords];

graphVertexCount[graph_Graph, ___] := VertexCount[graph];

graphVertexCount[edges_List, ___] /; !FreeQ[edges, DirectedEdge | UndirectedEdge | Rule | TwoWayRule] :=
  CountDistinct[Join[edges[[All, 1]], edges[[All, 2]]]];

graphVertexCount[vertices_List, edges_List, ___] := Length[vertices];
graphVertexCount[___] := 1;

countToSize[n_] := Which[
  n <= 3, 0.75, n <= 4, 0.8, n <= 5, 1, n <= 6, 1.5, n <= 7, 1.8, n <= 10, 2.0, n <= 15, 2.5,
  n <= 50, 3, n <= 100, 4, True, 5];


PackageExport["NiceGraph"]

NiceGraph[args___] := Graph[args,
  VertexStyle -> {EdgeForm[GrayLevel[0, .2]]},
  EdgeShapeFunction -> niceEdgeShapeFunction,
  GraphLayout -> {"VertexLayout" -> "SpringElectricalEmbedding", "PackingLayout"->"ClosestPackingCenter"},
  EdgeStyle -> Gray, ImageSize -> {100, 100} * countToSize[graphVertexCount[args]],
  Background -> GrayLevel[0.97], PlotRangePadding -> 0.25
];


PackageExport["ColorGraph"]

makeSegments[n_, center_ : {0, 0}, size_ : {1, 1}] :=
 makeSegments[n] =
  Table[Disk[center, size, {i, i + 1}*2 Pi/n], {i, 1, n}]

singleton[l_List] := l
singleton[expr_] := {expr}

vecWheel[vec_, center_, size_] :=
 Thread@Style[makeSegments[Length[singleton@vec], center, size],
   singleton@vec]

ColorGraph[args___]:=NiceGraph[args,
  VertexShapeFunction -> (vecWheel[#2, #1, #3] &), VertexSize -> 0.5]

HueColors[n_] := Table[Hue[i/(n+1),.8,1], {i,0,n-1}];


PackageExport["HypercubeColorGraph"]

HypercubeColorGraph[colors_] := Scope[
  n = Length[colors];
  logn = Log2[n];
  If[!IntegerQ[logn], Return[$Failed]];
  ColorGraph @ AdjacencyGraph[colors, AdjacencyMatrix @ HypercubeGraph[logn]]
]