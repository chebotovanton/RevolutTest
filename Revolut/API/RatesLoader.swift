import Alamofire

protocol RatesLoaderDelegate: class {
    func didReceiveRates(_ rates: [Rate])
}

class RatesLoader {

    weak var delegate: RatesLoaderDelegate?
    private let kBaseUrl = "https://revolut.duckdns.org/latest?base="

    func loadRates(baseCode: String) {
        addStatusBarActivityIndicator()
        let url = kBaseUrl + baseCode
        Alamofire.request(url).responseJSON { [weak self] (response) in
            if let rawValue = response.result.value as? [String : Any], var rates = ResultsParser.parseResults(rawValue) {
                rates.insert(Rate(code: baseCode, value: 1), at: 0)

                self?.delegate?.didReceiveRates(rates)
                self?.removeStatusBarActivityIndicator()
            } else {
                self?.handleLoadingError()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.loadRates(baseCode: baseCode)
            }
        }

    }

    private func handleLoadingError() {
        //do nothing
    }

    // move somewhere
    private func addStatusBarActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    private func removeStatusBarActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
