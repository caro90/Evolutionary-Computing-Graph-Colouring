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
    # e.g: for 10 columns(namely 10 number of vertices) and 2 colours, the vertices 1-5 in
    # every row represent the first colour and the 6-10 the second colour.
    colouringPartioning = Array{Array{Int64}}(numOfPopulation,numberOfColours)
    colouringPartioning(:)=0;
    for i=1:numOfPopulation
        #Assigning a color to every vertex. No particular preference
        temp=randperm(numberOfVertices);
        for j=1:numberOfColours
            for k=1:numberOfColours:numberOfVertices-1
                colouringPartioning[i,j]=append!(colouringPartioning[i,j],temp[k:k+numberOfColours-1])
            end
        end
    end

return graphAdjacencyMatrix, colouringPartioning
end
