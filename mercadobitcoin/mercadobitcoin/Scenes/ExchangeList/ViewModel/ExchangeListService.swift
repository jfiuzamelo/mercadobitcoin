import Foundation

protocol ExchangeListService {
    
    func getExchanges(then handler: @escaping (Result<[Exchange], NetworkError>) -> Void)
    func getLogo(then handler: @escaping (Result<[ExchangeLogo], NetworkError>) -> Void)
}

final class MBExchangeListService: ExchangeListService {

    private let dataRepository: DataRepository
        
    init(dataRepository: DataRepository = MercadoBitcoinRepository()) {
        self.dataRepository = dataRepository
    }
    
    func getExchanges(then handler: @escaping (Result<[Exchange], NetworkError>) -> Void) {
        dataRepository.getExchanges(then: handler)
    }
    
    func getLogo(then handler: @escaping (Result<[ExchangeLogo], NetworkError>) -> Void) {
        dataRepository.getExchangesLogo(then: handler)
    }
}
