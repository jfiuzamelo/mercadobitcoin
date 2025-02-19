import Foundation

protocol DataRepository {
    
    func getExchanges(with exchangeId: String,
                      then handler: @escaping (Result<[Exchange], NetworkError>) -> Void)
}

final class MercadoBitcoinRepository: DataRepository {
    
    // MARK: - Public Properties
    
    let serviceLayer: ServiceLayer

    init(serviceLayer: ServiceLayer = .init()) {
      self.serviceLayer = serviceLayer
    }
    
    func getExchanges(with exchangeId: String,
                           then handler: @escaping (Result<[Exchange], NetworkError>) -> Void) {
        serviceLayer.requestDataTask(
            endpoint: .exchanges(exchangeId), method: .GET, then: handler)
    }
}
