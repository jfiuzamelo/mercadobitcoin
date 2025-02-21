import Foundation

protocol DataRepository {
    
    func getExchanges(then handler: @escaping (Result<[Exchange], NetworkError>) -> Void)
    
    func getExchangeById(with exchangeId: String,
                         then handler: @escaping (Result<[Exchange], NetworkError>) -> Void)
    
    func getExchangesLogo(then handler: @escaping (Result<[ExchangeLogo], NetworkError>) -> Void)

}

final class MercadoBitcoinRepository: DataRepository {

    // MARK: - Public Properties
    
    let serviceLayer: ServiceLayer
    
    init(serviceLayer: ServiceLayer = .init()) {
        self.serviceLayer = serviceLayer
    }
    
    func getExchanges(then handler: @escaping (Result<[Exchange], NetworkError>) -> Void) {
        
        serviceLayer.requestDataTask(endpoint: .exchanges(),
                                     method: .GET,
                                     then: handler)
    }
    
    func getExchangeById(with exchangeId: String, then handler: @escaping (Result<[Exchange], NetworkError>) -> Void) {
        serviceLayer.requestDataTask(endpoint: .exchangeById(exchangeId),
                                     method: .GET,
                                     then: handler)
    }
    
    func getExchangesLogo(then handler: @escaping (Result<[ExchangeLogo], NetworkError>) -> Void) {
        serviceLayer.requestDataTask(endpoint: .exchangesLogo(),
                                     method: .GET,
                                     then: handler)
    }
}
