function graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng,populationSize)
    #temporary manual graphAdjacency matrix
#=  graphAdjacencyMatrix = Array{Int64}(5,2)
    graphAdjacencyMatrix[1,1] = 1 ;graphAdjacencyMatrix[1,2] = 4;
    graphAdjacencyMatrix[2,1] = 1 ;graphAdjacencyMatrix[2,2] = 2
    graphAdjacencyMatrix[3,1] = 2 ;graphAdjacencyMatrix[3,2] = 3
    graphAdjacencyMatrix[4,1] = 2 ;graphAdjacencyMatrix[4,2] = 4
    graphAdjacencyMatrix[5,1] = 3 ;graphAdjacencyMatrix[5,2] = 4
=#
    graphAdjacencyMatrix=datasetLoading(datasetPath)
    #--------------------------------
    # Create a 2D Array:
    # Every row represents a solution of coloured vertices
    # The columns are divided by the number of colours
    population=Array{Array{Int64}}(populationSize,numberOfColours)
    for i=1:populationSize
        for j=1:numberOfColours
            population[i,j] = Array{Int64}(0)
        end
    end
    for i=1:populationSize
        #Assigning a color to every vertex. No particular preference
        for j=1:numberOfVertices
               append!(population[i, rand(rng, 1:numberOfColours)], j)
        end
    end
return graphAdjacencyMatrix, population
end
