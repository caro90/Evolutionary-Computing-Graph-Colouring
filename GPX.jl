#Greedy Partitionioning Crossover Implementation
function GPX(population,populationSize,numberOfVertices,numberOfColours,rng)
    #The number of offsprings are half the number of parents
    offsprings=Array{Array{Int64}}(div(populationSize,2),numberOfColours)
    #Offsprings Initialization
    for i=1:div(populationSize,2)
        for j=1:numberOfColours
            offsprings[i,j] = Array{Int64}(0)
        end
    end
    indices1=1;
    for i=1:2:populationSize-1
        tempParent1=deepcopy(population[i,:])
        tempParent2=deepcopy(population[i+1,:])
        for l=1:numberOfColours
            if mod(l,2)==1
            #choose largest subset color from 1st parent
                maxCardinalitySubset=deepcopy(tempParent1[1])
                for k=2:numberOfColours
                    if length(maxCardinalitySubset)<length(tempParent1[k])
                        maxCardinalitySubset=deepcopy(tempParent1[k]);
                    end
                end
                # Adding the element in offsprings
                offsprings[indices1,l]=deepcopy(maxCardinalitySubset);
                #Removing all the occurrences of the current vertices from both parent solutions
                for j1=1:length(maxCardinalitySubset)
                    for j2=1:numberOfColours
                            filter!(x->x≠maxCardinalitySubset[j1],tempParent2[j2])
                            filter!(x->x≠maxCardinalitySubset[j1],tempParent1[j2])
                    end
                end
            else
            #choose largest subset color from 2nd parent
                maxCardinalitySubset=deepcopy(tempParent2[1])
                for k=2:numberOfColours
                    if length(maxCardinalitySubset)<length(tempParent2[k])
                        maxCardinalitySubset=deepcopy(tempParent2[k]);
                    end
                end
                # Adding the element in offsprings
                offsprings[indices1,l]=deepcopy(maxCardinalitySubset);
                #Removing all the occurrences of the current vertices from both parent solutions
                for j1=1:length(maxCardinalitySubset)
                    for j2=1:numberOfColours
                            filter!(x->x≠maxCardinalitySubset[j1],tempParent2[j2])
                            filter!(x->x≠maxCardinalitySubset[j1],tempParent1[j2])
                    end
                end
            end
        end
        #Randomly assign the remaining vertices of the parents:
        for l=1:numberOfColours
            if !isempty(tempParent1[l])
                  append!(offsprings[indices1, rand(rng, 1:numberOfColours)], tempParent1[l])
            end
        end
        indices1=indices1+1;
    end
return population,offsprings
end
