import Foundation
import UIKit

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = EnvironmentSetup.host
        components.queryItems = queryItems
        components.path = "/v1/" + path
        return components.url
    }
}

extension Endpoint {
    static func exchanges(_ exchangeId: String) -> Endpoint {
        let queryItem = URLQueryItem(name: "exchange_id", value: "\(exchangeId)")
        return Endpoint(path: "exchanges", queryItems: [queryItem])
    }
}
