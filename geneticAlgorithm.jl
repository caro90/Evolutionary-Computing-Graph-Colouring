function geneticAlgorithm(population,graphAdjacencyMatrix,populationSize,numberOfVertices,numberOfColours,rng)
    conflicts=0;
    V=Array{Int64}(Int(4));
    progressFlags=Array{Int64}(Int(populationSize))
    progressFlags[:]=0;
    progress=0;
    numOfGenerations=1;
    moveCountsVDLS=zeros(Array{Int64}(populationSize))

    while progress!=-1
        averageConflicts = 0
        #1)Shuffling the population:
        population=population[shuffle(1:end),:]
        #2)Pairing using crossover:
        offsprings=GPX(population,populationSize,numberOfVertices,numberOfColours,rng)
        #3)Family competition
        #Apply Local Search Vertex Descent to every Offspring Solution
        Threads.@threads for i=1:populationSize
            solution=deepcopy(offsprings[i,:]);
            moveCountVDLS,offsprings[i,:]=VDLS(graphAdjacencyMatrix, solution, numberOfVertices, rng)
            moveCountsVDLS[i] += moveCountVDLS
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

            averageConflicts += conflictsParent1 / populationSize
            averageConflicts += conflictsParent2 / populationSize

            ## Checking whether or not a solution found.
            if conflictsOffspring1==0   ||
               conflictsOffspring2==0   ||
               conflictsParent1==0      ||
               conflictsParent2==0
                #Solution found: No conflicting edges=> k-colouring possible
                progress=-1;
                println("Solution Found")
                println("Population=");print(populationSize)
                println("numberOfColours=");print(numberOfColours)
                print("Vertex Descent moves=");println(sum(moveCountsVDLS))
                print("Number of generations=");println(numOfGenerations)
            end

            V[:]=sortperm([ conflictsOffspring1,conflictsOffspring2,conflictsParent1,conflictsParent2])
            if V[1]==1
                population[i-1,:]=deepcopy(offsprings[i-1,:])
                progressFlags[i-1]=1;
            end
            if V[1]==2
                population[i-1,:]=deepcopy(offsprings[i,:])
                progressFlags[i-1]=1;
            end
            if V[2]==1
                population[i,:]=deepcopy(offsprings[i-1,:])
                progressFlags[i]=1;
            end
            if V[2]==2
                population[i,:]=deepcopy(offsprings[i,:])
                progressFlags[i]=1;
            end


        end
        # When no ofspring solution has entered the next generation,
        # then the GA run is stopped.
        if sum(progressFlags)==0
            println("No Progress, GA terminated")
            print("Population=");     println(populationSize)
            print("numberOfColours=");println(numberOfColours)
            progress=-1;
            print("Vertex Descent moves=");println(sum(moveCountsVDLS))
            print("Number of generations=");println(numOfGenerations)
        end
        progressFlags[:]=0;
        numOfGenerations+=1;

        println(averageConflicts)
    end
end
