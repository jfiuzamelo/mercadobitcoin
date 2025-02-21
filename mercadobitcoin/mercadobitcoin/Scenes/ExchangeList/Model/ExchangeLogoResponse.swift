import Foundation

struct ExchangeLogo: Codable, Equatable {
    
    var exchangeId: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case url
    }
}
