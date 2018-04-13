using StatsBase
include("countConflictingEdges.jl")
include("graphColouringInitialization.jl")
include("datasetLoading.jl")
include("VDLS.jl")
include("GPX.jl")
include("geneticAlgorithm.jl")
rng = MersenneTwister(Dates.millisecond(now()))
datasetPath=string(pwd(), "\\Datasets\\le450_15_graph.csv")

populationSize=100
numberOfVertices=450
numberOfColours=18
conflicts=0;
graphAdjacencyMatrix,population=graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng,populationSize)

offsprings=GPX(population,populationSize,numberOfVertices,numberOfColours,rng)


conflicts=geneticAlgorithm(population,graphAdjacencyMatrix,populationSize,numberOfVertices,numberOfColours,rng)

#=
print("Started\n")
print(string(population[2,:], "<-- Before \n"))
colorpart1=deepcopy(population[3,:]);
population[2,:]=VDLS(graphAdjacencyMatrix,colorpart1,numberOfVertices,rng)
print(string("After:", population[2,:], "<-- After \n"))
=#
