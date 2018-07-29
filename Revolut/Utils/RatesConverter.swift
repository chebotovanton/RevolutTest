class RatesConverter {

    static func convert(amount: Double, from: Rate, to: Rate) -> Double {
        return amount * to.value / from.value
    }

}
