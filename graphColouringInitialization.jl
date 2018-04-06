 #function graphColouringInitialization(graphAdjacencyMatrix)

    #temporary manual graphAdjacency matrix
    graphAdjacencyMatrix = Array{Int64}(6,2)
    graphAdjacencyMatrix[1,1] = 1
    graphAdjacencyMatrix[1,2] = 4

    graphAdjacencyMatrix[2,1] = 1
    graphAdjacencyMatrix[2,2] = 2

    graphAdjacencyMatrix[3,1] = 2
    graphAdjacencyMatrix[3,2] = 3

    graphAdjacencyMatrix[4,1] = 2
    graphAdjacencyMatrix[4,2] = 4

    graphAdjacencyMatrix[5,1] = 3
    graphAdjacencyMatrix[5,2] = 4
    numberOfVertices = 4
    #--------------------------------
    numberOfColors = 2
    colouringPartioning = Array{Array{Int64}}(numberOfColors)
    for i=1:numberOfColors
        colouringPartioning[i] = Array{Int64}(0)
    end

    j = 1
    for i=1:numberOfVertices
        colouringPartioning[j]=append!(colouringPartioning[j],i)
        j = j + 1
        if (j==K)
            j = 1
        end
    end

#end
