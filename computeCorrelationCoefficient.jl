function computeCorrelationCoefficient(parents, offspring)
    N = size(parents, 1)

    meanParents = 0
    meanOffspring = 0

    sdParents = 0
    sdOffspring = 0

    covariance = 0

    # Calculate mean fitness of parents and offspring
    for i=1:N
        meanParents += parents[i] / N
        meanOffspring += offspring[i] / N
    end

    for i=1:N
        # Calculate variance of fitness of parents and offspring
        sdParents += (parents[i] - meanParents)^2 / N
        sdOffspring += (offspring[i] - meanOffspring)^2 / N

        # Calculate covariance
        covariance += ((parents[i] - meanParents) * (offspring[i] - meanOffspring)) / N
    end

    # Calculate standard deviations from variances
    sdParents = √sdParents
    sdOffspring = √sdOffspring

return covariance / (sdParents * sdOffspring)
end
