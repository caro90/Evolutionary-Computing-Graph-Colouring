function geneticAlgorithm(population,graphAdjacencyMatrix,populationSize,numberOfVertices,numberOfColours,rng)
    progress=0;
    while progress!=-1
        #1)Shuffling the population: ***
        #2)Pairing using crossover:
        population,offsprings=GPX(population,populationSize,numberOfVertices,numberOfColours,rng)
        #3) Evaluate Fitness:
        for i=1:populationSize
            solution=population[i,:];
            population[i,:]=VDLS(graphAdjacencyMatrix,solution,numberOfVertices,rng)
        end
    end
end
