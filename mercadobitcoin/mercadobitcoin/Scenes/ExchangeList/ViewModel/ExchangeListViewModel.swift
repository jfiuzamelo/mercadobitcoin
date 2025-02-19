import Foundation
import Combine
import UIKit

class ExchangeListViewModel {
    private var model: [Exchange]? = []
    private let dataRepository: ExchangeListService

    // MARK: - Init
    
    init(repository: ExchangeListService = MBExchangeListService() ) {
        dataRepository = repository
    }
}

extension ExchangeListViewModel {
    
    func getExchanges() -> Future<Void, NetworkError> {
        Future { promise in
            self.dataRepository.getExchanges(with: "BTC") { completion in
                switch completion {
                case .success(let response):
                    self.model = response

                    promise(Result.success(()))
                case .failure(let error):
                    print(error.localizedDescription)
                    promise(.failure(error))
                }
            }
        }
    }
}
