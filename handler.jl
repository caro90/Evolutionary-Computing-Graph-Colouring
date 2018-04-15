#function handler()
using StatsBase
include("countConflictingEdges.jl")
include("graphColouringInitialization.jl")
include("datasetLoading.jl")
include("VDLS.jl")
include("GPX.jl")
include("geneticAlgorithm.jl")
rng = MersenneTwister(Dates.millisecond(now()))
datasetPath=string(pwd(), "\\Datasets\\le450_15_graph.csv")
numOfGenerations=0;
populationSize=100
numberOfVertices=450
numberOfColours=15
tic()
graphAdjacencyMatrix,population=graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng,populationSize)
numOfGenerations=geneticAlgorithm(population,graphAdjacencyMatrix,populationSize,numberOfVertices,numberOfColours,rng)
executionTiming=toc()
#end
