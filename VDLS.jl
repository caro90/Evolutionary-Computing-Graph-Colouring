include("createVertexColoursArray.jl")

function VDLS(graphAdjacencyMatrix, colouringPartioning, numberOfVertices, rng)

    numberOfColours = size(colouringPartioning, 1)

    # Create array with vertex colours for quick access
    vertexColours = createVertexColoursArray(colouringPartioning, numberOfVertices)

    # Create an array of vertex indices in a random order
    traverserOrder = sample(1:numberOfVertices, numberOfVertices, replace = false)

    conflictsAfter = countConflictingEdges(graphAdjacencyMatrix, vertexColours)
    conflictsBefore = conflictsAfter + 1

    # Perform vertex decent until no improvement was made
    iterationsWithoutImprovement = 0
    while iterationsWithoutImprovement < 100 #100 TODO back to 100

        # Traverse over all vertices in a random order
        for i=1:numberOfVertices
            v = traverserOrder[i]
            colour = vertexColours[v]
            conflicts = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

            bestImprovement = (colour, conflicts)

            # Find the best improvement for this vertex
            for j=1:numberOfColours
                if j==colour
                    continue
                end

                vertexColours[v] = j

                newConflicts = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

                if newConflicts < bestImprovement[2] || (newConflicts == bestImprovement[2] && rand(rng, [0,1]) == 1)
                    bestImprovement = (j, newConflicts)
                end
            end

            # Change the colour of the vertex to the colour that gives the best improvement
            newColour = bestImprovement[1]
            filter!(e->e!=v, colouringPartioning[colour]) # Remove vertex from old colour subset
            append!(colouringPartioning[newColour], v) # Add vertex to new colour subset
            vertexColours[v] = newColour # Also update vertex colours array

        end

        conflictsBefore = conflictsAfter
        conflictsAfter = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

        if conflictsAfter >= conflictsBefore
            iterationsWithoutImprovement += 1
        else
            iterationsWithoutImprovement = 0
        end
    end

return colouringPartioning
end
