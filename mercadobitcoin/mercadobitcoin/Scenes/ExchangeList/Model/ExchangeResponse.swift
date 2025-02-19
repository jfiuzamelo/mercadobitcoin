import Foundation

struct Exchange: Codable, Equatable {
    
    var exchangeId: String?
    var website: String?
    var name: String?
    var dataQuoteStart: String?
    var dataQuoteEnd: String?
    var dataOrderBookStart: String?
    var dataOrderBookEnd: String?
    var dataTradeStart: String?
    var dataTradeEnd: String?
    var dataSymbolsCount: Int?
    var volume1hrsUsd: Double?
    var volume1dayUsd: Double?
    var volume1mthUsd: Double?
    var rank: Int?
    
    enum CodingKeys: String, CodingKey {
        case website
        case name
        case exchangeId = "exchange_id"
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderBookStart = "data_orderbook_start"
        case dataOrderBookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volume1hrsUsd = "volume_1hrs_usd"
        case volume1dayUsd = "volume_1day_usd"
        case volume1mthUsd = "volume_1mth_usd"
    }
    
}
