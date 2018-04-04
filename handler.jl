graphAdjacency = Array{Int64}(6,2)
graphAdjacency[1,1] = 1
graphAdjacency[1,2] = 4

graphAdjacency[2,1] = 1
graphAdjacency[2,2] = 2

graphAdjacency[3,1] = 2
graphAdjacency[3,2] = 3

graphAdjacency[4,1] = 2
graphAdjacency[4,2] = 4

graphAdjacency[5,1] = 3
graphAdjacency[5,2] = 4
numberOfVertices = 4

K = 3
s = Array{Array{Int64}}(K)

for i=1:K
    s[i] = Array{Int64}(0)
end

j = 1
for i=1:numberOfVertices
    s[j]=append!(s[j],i)

    j = j + 1
    if j==K
        j = 1
    end
end
