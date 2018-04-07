function createVertexColoursArray(colouringPartioning, numberOfVertices)

    vertexColours = Array{Int64}(numberOfVertices)
    for i=1:size(colouringPartioning, 1)
        for j=1:size(colouringPartioning[i], 1)
            vertexColours[colouringPartioning[i][j]] = i
        end
    end

return vertexColours
end
