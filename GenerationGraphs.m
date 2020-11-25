Package["EvolutionGraphs`"]

PackageImport["GeneralUtilities`"]


SetUsage @ "
generationSuccessorFunction[generationVector$, mutations$] takes a generation$ vector$ and a \
successor association which reflects the valid mutations$ and outputs the valid generation vector successors.
"

generationSuccessorFunction[generationVector_, mutations_] := With[
  {n = Length[generationVector]},
  Map[
    If[MemberQ[generationVector, #], Nothing,
      Sort @ Append[generationVector, #]]&,
    Union @@ Lookup[mutations, generationVector]
  ]
];


PackageExport["GenerationGraph"]

SetUsage @ "
GenerationGraph[mutationGraph$] translates the valid mutations, as represented in the mutation$ graph$ \
and shows the resulting valid generation level updates (genetic drift).
"

GenerationGraph[mutationGraph_] := Module[
  {genotypes, generationVectors, mutations, successorAssociation},
  genotypes = VertexList[mutationGraph];
  generationVectors = Subsets[Sort @ genotypes, {1, Length[genotypes]}];
  mutations = GraphToSuccessorAssociation[mutationGraph, "IncludeSelf" -> False];
  (* allowedMutants association maps a genotype to a list of distance \[LessEqual] 1 genotypes *)
  successorAssociation = AssociationMap[generationSuccessorFunction[#, mutations]&, generationVectors];
  NiceGraph @ SuccessorAssociationToGraph[successorAssociation, Options[mutationGraph]]
];
