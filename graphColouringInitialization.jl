 function graphColouringInitialization(datasetPath,numberOfVertices,numberOfColors)
    #= #temporary manual graphAdjacency matrix
        graphAdjacencyMatrix = Array{Int64}(6,2)
        graphAdjacencyMatrix[1,1] = 1 ;graphAdjacencyMatrix[1,2] = 4;
        graphAdjacencyMatrix[2,1] = 1 ;graphAdjacencyMatrix[2,2] = 2
        graphAdjacencyMatrix[3,1] = 2 ;graphAdjacencyMatrix[3,2] = 3
        graphAdjacencyMatrix[4,1] = 2 ;graphAdjacencyMatrix[4,2] = 4
        graphAdjacencyMatrix[5,1] = 3 ;graphAdjacencyMatrix[5,2] = 4 =#
        graphAdjacencyMatrix=datasetLoading(datasetPath)
        #--------------------------------
        #Create an Array which to contains the colors of every vertex
        colouringPartioning = Array{Array{Int64}}(numberOfColors)
        for i=1:numberOfColors
            colouringPartioning[i] = Array{Int64}(0)
        end
        #Assigning a color to every vertex. No particular preference
        j = 0;
        for i=1:numberOfVertices
            j=j+1;
            if (j>numberOfColors)
                j = 1
            end
            colouringPartioning[j]=append!(colouringPartioning[j],i)
        end
        #Assigning a color to every vertex. No particular preference
        j = 0;
        for i=1:numberOfVertices
            j=j+1;
            if (j>numberOfColors)
                j = 1
            end
            colouringPartioning[j]=append!(colouringPartioning[j],i)
        end
return graphAdjacencyMatrix, colouringPartioning
end
