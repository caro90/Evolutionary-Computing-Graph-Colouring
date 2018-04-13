using StatsBase
include("countConflictingEdges.jl")
include("graphColouringInitialization.jl")
include("datasetLoading.jl")
include("VDLS.jl")
include("GPX.jl")
rng = MersenneTwister(Dates.millisecond(now()))
datasetPath=string(pwd(), "\\Datasets\\le450_15_graph.csv")

populationSize=10
numberOfVertices=450
numberOfColours=2
graphAdjacencyMatrix,population=graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng,populationSize)

population,offsprings=GPX(population,populationSize,numberOfVertices,numberOfColours,rng)
#population=[population,offsprings]

print("Started\n")
print(string(colouringPartioning, "<-- Before \n"))
colorpart1=population[2,:];
population[2,:]=VDLS(graphAdjacencyMatrix,colorpart1,numberOfVertices,rng)
print(string("After:", colouringPartioning, "<-- After \n"))
