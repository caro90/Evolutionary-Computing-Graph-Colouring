function geneticAlgorithm(population,graphAdjacencyMatrix,populationSize,numberOfVertices,numberOfColours,rng)
    progress=0;
    conflicts=0;
    newGen=deepcopy(population)
    V=Array{Int64}(Int(3));
    while progress!=-1
        #1)Shuffling the population: ***
        #2)Pairing using crossover:
        offsprings=GPX(newGen,populationSize,numberOfVertices,numberOfColours,rng)
        #3)Family competition
        #Apply Local Search Vertex Descent to every Offspring Solution
        for i=1:div(populationSize,2)
            solution=deepcopy(offsprings[i,:]);
            offsprings[i,:]=VDLS(graphAdjacencyMatrix, solution, numberOfVertices, rng)
        end

        for i=2:2:populationSize
            # Create array with vertex colours for quick access
            vertexColours = createVertexColoursArray(offsprings[div(i,2),:], numberOfVertices)
            conflictsOffspring = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

            vertexColours = createVertexColoursArray(newGen[i-1,:], numberOfVertices)
            conflictsParent1 = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

            vertexColours = createVertexColoursArray(newGen[i,:], numberOfVertices)
            conflictsParent2 = countConflictingEdges(graphAdjacencyMatrix, vertexColours)
            if conflictsOffspring==0 || conflictsParent1==0 || conflictsParent2==0
                #Solution found: No conflicting edges=> k-colouring possible
                progress=-1;
            end

            V[:]=sortperm([ conflictsOffspring,conflictsParent1,conflictsParent2 ])

            if V[2]==1
                newGen[i-1,:]=offSprings[i,:]
            end
            if V[3]==1
                newGen[i-1,:]=offSprings[i,:]
            end

        end
        # When no ofspring solution has entered the next generation,
        # then the GA run is stopped.
        #=try
            if ( minimum(population-newGen)==0
                    progress=-1;
            end
        catch e
            println
            progress=-1;
        end

        population=newGen=#
    end

return conflicts
end
