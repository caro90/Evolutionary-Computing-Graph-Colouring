function graphColouringInitialization(datasetPath,numberOfVertices,numberOfColours,rng,numOfPopulation)
    #temporary manual graphAdjacency matrix
    #=graphAdjacencyMatrix = Array{Int64}(5,2)
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
    colouringPartioning=Array{Array{Int64}}(numOfPopulation,numberOfColours)
    for i=1:numOfPopulation
        #Assigning a color to every vertex. No particular preference
        temp=randperm(numberOfVertices);
        k=0;
        for j=1:numberOfColours
               colouringPartioning[i,j]=append!(colouringPartioning[i,j],temp[k+1:k+1+div(numberOfVertices,numberOfColours)-1])
               k=k+div(numberOfVertices,numberOfColours)
        end
    end

return graphAdjacencyMatrix, colouringPartioning
end
