function datasetLoading(datasetPath)
    f=open(datasetPath);
    lines = readlines(f)
    close(f)

    #While loop for figuring out the size of the graphAdjacencyMatrix
    counter=1
    while (lines[counter][1]!='e')
        counter=counter+1
    end
    graphAdjacencyMatrix=Array{Int64}(length(lines)-counter+1,2)
    graphAdjacencyMatrix[:]=0;

    #=temp1 and temp2 variables to determine the exact position of the edgenumber
      in the string
    =#
    for i=counter:length(lines)
        if lines[i][1]=='e'
            temp1=1;
            for k=1:2
                while (lines[i][temp1]!=' ')
                    temp1=temp1+1
                end
                temp1=temp1+1

                temp2=temp1;
                while temp2 < length(lines[i]) && lines[i][temp2]!=' '
                    temp2=temp2+1
                end

                tempString=lines[i][temp1:temp2]
                graphAdjacencyMatrix[i-counter+1,k]=parse(Int,tempString)
            end
        end
    end
return graphAdjacencyMatrix
end
