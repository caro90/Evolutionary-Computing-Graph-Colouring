function geneticAlgorithm(population,graphAdjacencyMatrix,populationSize,numberOfVertices,numberOfColours,rng)
    conflicts=0;
    V=Array{Int64}(Int(4));
    progressFlags=Array{Int64}(Int(populationSize))
    progressFlags[:]=0;
    progress=0;

    while progress!=-1
        #1)Shuffling the population:
        population=population[shuffle(1:end),:]
        #2)Pairing using crossover:
        offsprings=GPX(population,populationSize,numberOfVertices,numberOfColours,rng)
        #3)Family competition
        #Apply Local Search Vertex Descent to every Offspring Solution
        for i=1:populationSize
            solution=deepcopy(offsprings[i,:]);
            offsprings[i,:]=VDLS(graphAdjacencyMatrix, solution, numberOfVertices, rng)
        end

        for i=2:2:populationSize
            # Create array with vertex colours for quick access
            vertexColours = createVertexColoursArray(offsprings[i-1,:], numberOfVertices)
            conflictsOffspring1 = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

            vertexColours = createVertexColoursArray(offsprings[i,:], numberOfVertices)
            conflictsOffspring2 = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

            vertexColours = createVertexColoursArray(population[i-1,:], numberOfVertices)
            conflictsParent1 = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

            vertexColours = createVertexColoursArray(population[i,:], numberOfVertices)
            conflictsParent2 = countConflictingEdges(graphAdjacencyMatrix, vertexColours)

            if conflictsOffspring1==0 ||conflictsOffspring2==0 || conflictsParent1==0 || conflictsParent2==0
                #Solution found: No conflicting edges=> k-colouring possible
                progress=-1;
                println("Solution Found")
            end

            V[:]=sortperm([ conflictsOffspring1,conflictsOffspring2,conflictsParent1,conflictsParent2])

            if V[3]==1
                population[i-1,:]=offsprings[i-1,:]
                progressFlags[i-1]=1;
            end
            if V[3]==2
                population[i-1,:]=offsprings[i,:]
                progressFlags[i-1]=1;
            end
            if V[4]==1
                population[i,:]=offsprings[i-1,:]
                progressFlags[i]=1;
            end
            if V[4]==2
                population[i,:]=offsprings[i,:]
                progressFlags[i]=1;
            end

        end
        # When no ofspring solution has entered the next generation,
        # then the GA run is stopped.
        if sum(progressFlags==0)
            println("No Progress, GA terminated")
            progress=-1;
        end
        progressFlags[:]=0;
    end
end
