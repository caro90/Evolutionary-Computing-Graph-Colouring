using StatsBase
include("graphColouringInitialization.jl")
include("datasetLoading.jl")
include("VDLS.jl")
rng = MersenneTwister(Dates.millisecond(now()))
datasetPath=string(pwd(), "\\Datasets\\le450_15_graph.csv")

numberOfVertices=4
numberOfColours=3

graphAdjacencyMatrix,colouringPartioning=graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng)

print("Started\n")
print(string(colouringPartioning, "<-- Before \n"))
colouringPartioning=VDLS(graphAdjacencyMatrix,colouringPartioning,numberOfVertices,rng)
print(string("After:", colouringPartioning, "<-- After \n"))
