function countConflictingEdges(graphAdjacencyMatrix, vertexColours)
    conflicts = 0

    # Count the amount of edges that connect two vertices with the same colour
    for i=1:size(graphAdjacencyMatrix, 1)
        if vertexColours[graphAdjacencyMatrix[i, 1]] == vertexColours[graphAdjacencyMatrix[i, 2]]
            conflicts = conflicts + 1
        end
    end
    
return conflicts
end
