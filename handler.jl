#function handler()
using StatsBase
include("countConflictingEdges.jl")
include("graphColouringInitialization.jl")
include("datasetLoading.jl")
include("VDLS.jl")
include("GPX.jl")
include("geneticAlgorithm.jl")
include("experimentCorrelation.jl")
rng = MersenneTwister(Dates.millisecond(now()))
datasetPath=string(pwd(), "\\Datasets\\le450_15_graph.csv")
print(string("Started\n"))

populationSize=100
numberOfVertices=450
numberOfColours=18

tic()
graphAdjacencyMatrix=datasetLoading(datasetPath)
population=graphColouringInitialization(numberOfVertices,numberOfColours,rng,populationSize)
geneticAlgorithm(population,graphAdjacencyMatrix,populationSize,numberOfVertices,numberOfColours,rng)
executionTiming=toc()

#experimentCorrelation(graphAdjacencyMatrix,numberOfVertices,numberOfColours,populationSize,rng)
