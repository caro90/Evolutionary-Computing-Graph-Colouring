using StatsBase
include("countConflictingEdges.jl")
include("graphColouringInitialization.jl")
include("datasetLoading.jl")
include("VDLS.jl")
rng = MersenneTwister(Dates.millisecond(now()))
datasetPath=string(pwd(), "\\Datasets\\le450_15_graph.csv")

numOfPopulation=10
numberOfVertices=10
numberOfColours=2

graphAdjacencyMatrix,colouringPartioning=graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng,numOfPopulation)
#=
print("Started\n")
print(string(colouringPartioning, "<-- Before \n"))
colouringPartioning=VDLS(graphAdjacencyMatrix,colouringPartioning,numberOfVertices,rng)
print(string("After:", colouringPartioning, "<-- After \n"))
=#
