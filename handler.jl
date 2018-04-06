include("graphColouringInitialization.jl")
include("datasetLoading.jl")
datasetPath="C:/Users/Chris/AppData/Local/JuliaPro-0.6.2.1/EC_practical2/Datasets/le450_15_graph.csv"
numberOfVertices=450
numberOfColors=10
graphAdjacencyMatrix,colouringPartioning=graphColouringInitialization(datasetPath,numberOfVertices,numberOfColors)
