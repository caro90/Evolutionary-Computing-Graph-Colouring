using StatsBase
include("countConflictingEdges.jl")
include("graphColouringInitialization.jl")
include("datasetLoading.jl")
include("VDLS.jl")
include("GPX.jl")
rng = MersenneTwister(Dates.millisecond(now()))
datasetPath=string(pwd(), "\\Datasets\\le450_15_graph.csv")

populationSize=20
numberOfVertices=10
numberOfColours=2
graphAdjacencyMatrix,population=graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng,populationSize)

population2,offsprings=GPX(population,populationSize,numberOfVertices,numberOfColours,rng)
#=
print("Started\n")
print(string(colouringPartioning, "<-- Before \n"))
colouringPartioning=VDLS(graphAdjacencyMatrix,colouringPartioning,numberOfVertices,rng)
print(string("After:", colouringPartioning, "<-- After \n"))
=#
