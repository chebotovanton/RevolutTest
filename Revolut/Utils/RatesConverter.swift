class RatesConverter {

    static func convert(amount: Double, fromRate: Rate, toRate: Rate) -> Double {
        if fromRate.value > 0 {
            return amount * toRate.value / fromRate.value
        }
        return 0
    }

}
