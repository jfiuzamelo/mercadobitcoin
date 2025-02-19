import Foundation

protocol ExchangeListService {
    
    func getExchanges(with exchangeId: String,
                           then handler: @escaping (Result<[Exchange], NetworkError>) -> Void)
    
}

final class MBExchangeListService: ExchangeListService {

    private let dataRepository: DataRepository
        
    init(dataRepository: DataRepository = MercadoBitcoinRepository()) {
        self.dataRepository = dataRepository
    }
    
    func getExchanges(with exchangeId: String, then handler: @escaping (Result<[Exchange], NetworkError>) -> Void) {
        dataRepository.getExchanges(with: exchangeId, then: handler)
    }
}
