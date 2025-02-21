import Foundation
import UIKit

struct ExchangeModel {
    var exchangeId: String?
    var website: String?
    var name: String?
    var image: UIImage?
    var url: String?
    
    init(exchangeId: String? = nil, website: String? = nil, name: String? = nil, image: UIImage? = nil, url: String? = nil) {
        self.exchangeId = exchangeId
        self.website = website
        self.name = name
        self.image = image
        self.url = url
    }
}
