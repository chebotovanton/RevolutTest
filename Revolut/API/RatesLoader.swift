import Alamofire
import PromiseKit

protocol RatesLoaderDelegate: class {
    func didReceiveRates(_ rates: [Rate])
}

class RatesLoader {

    weak var delegate: RatesLoaderDelegate?

    func loadRates(baseCode: String) {
        addStatusBarActivityIndicator()
        let url = "https://revolut.duckdns.org/latest?base=" + baseCode
        Alamofire.request(url).responseJSON { [weak self] (response) in
            guard let rawValue = response.result.value as? [String : Any] else {
                self?.handleLoadingError()
                return
            }

            guard let rates = ResultsParser.parseResults(rawValue) else  {
                self?.handleParsingError()
                return
            }

            self?.delegate?.didReceiveRates(rates)
            self?.removeStatusBarActivityIndicator()
        }
        //restart in 1 second
    }

    private func handleLoadingError() {
        //do nothing
    }

    private func handleParsingError() {
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
