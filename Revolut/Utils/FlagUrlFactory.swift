import Foundation

class FlagUrlFactory {

    static func countryFlagUrl(_ currencyCode: String) -> String {

        // That's the sucker punch, I know

        let lowercasedCode = currencyCode.lowercased()
        return "https://raw.githubusercontent.com/transferwise/currency-flags/master/src/flags/" + lowercasedCode + ".png"
    }
}
