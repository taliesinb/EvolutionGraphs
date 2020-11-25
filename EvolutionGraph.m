Package["EvolutionGraphs`"]

PackageImport["GeneralUtilities`"]


PackageExport["EvolutionGraph"]

EvolutionGraph[mutationGraph_,fitnessGraph_] :=
  ColorGraph @ GraphUnion[GenerationGraph[mutationGraph], SelectionGraph[fitnessGraph]];

SetUsage @ "
EvolutionGraph[mutationGraph$, fitnessGraph$] creates the generation level updates based \
on a mutation$ graph$ and a fitness$ graph$ (evolution).
"