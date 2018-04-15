include("computeCorrelationCoefficient.jl")

function experimentCorrelation(graphAdjacencyMatrix,numberOfVertices,numberOfColours,populationSize,rng)

    averageCorrelation = zeros(Array{Float64}(2))

    useVDLS = 0
    for i=1:2
        # Generate random parent pool
        parents=graphColouringInitialization(numberOfVertices,numberOfColours,rng,populationSize)

        if useVDLS == 1
            # Perform VDLS
            for j=1:populationSize
                moveCountVDLS,parents[j,:]=VDLS(graphAdjacencyMatrix, parents[j,:], numberOfVertices, rng)
                print(string(j, ", "))
            end
        end

        # Create offspring solutions
        offspring=GPX(parents,populationSize,numberOfVertices,numberOfColours,rng)

        # Calculate fitness of parents and offspring
        fitnessParents = Array{Int64}(populationSize)
        fitnessOffspring = Array{Int64}(populationSize)

        for j=1:populationSize
            vertexColours = createVertexColoursArray(parents[j,:], numberOfVertices)
            fitnessParents[j] = countConflictingEdges(graphAdjacencyMatrix,vertexColours)

            vertexColours = createVertexColoursArray(offspring[j,:], numberOfVertices)
            fitnessOffspring[j] = countConflictingEdges(graphAdjacencyMatrix,vertexColours)
        end

        # Compute average correlation coefficient of the 5 independent runs
        averageCorrelation[useVDLS + 1] += computeCorrelationCoefficient(fitnessParents,fitnessOffspring) / 5

        if i==1
            # Switch to using VDLS for the next 5 runs
            useVDLS = 1
        end
        print(string(i , "/ 2 \n"))
    end

    print(string("================================\n","GPX correlation coefficient\n"))
    print(string("Without VDLS: ", averageCorrelation[1] ,"\n"))
    print(string("\nWith VDLS: ", averageCorrelation[2] ,"\n================================\n"))
end
