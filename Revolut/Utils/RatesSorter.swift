class RatesSorter {

    static func reorderRates(newRates: [Rate], oldRates: [Rate]) -> [Rate] {
        var newCopy = newRates
        var result: [Rate] = []
        for rate in oldRates {
            if let index = newCopy.index(where: { $0.code == rate.code }) {
                result.append(newCopy[index])
                newCopy.remove(at: index)
            } else {
                result.append(rate)
            }
        }
        result.append(contentsOf: newCopy)

        return result
    }
    
}
