//
//  GlobalModel.swift
//  IsisMarketCoins
//
//  Created by Guilherme Silveira de Souza on 16/10/23.
//

import Foundation

struct GlobalModel: Codable {
    let data: CryptocurrencyModel
}

// MARK: - CryptocurrencyModel
struct CryptocurrencyModel: Codable{
    let active_cryptocurrencies: Int
    let upcoming_icos: Int
    let ongoing_icos: Int
    let ended_icos: Int
    let markets: Int
    let total_market_cap: [String: Double]
    let total_volume: [String: Double]
    let market_cap_percentage: [String: Double]
    let market_cap_change_percentage_24h_usd: Double
    let updated_at: Int
    
    enum CodingKeys: String, CodingKey {
        case active_cryptocurrencies = "active_cryptocurrencies"
        case upcoming_icos = "upcoming_icos"
        case ongoing_icos = "ongoing_icos"
        case ended_icos = "ended_icos"
        case markets
        case total_market_cap = "total_market_cap"
        case total_volume = "total_volume"
        case market_cap_percentage = "market_cap_percentage"
        case market_cap_change_percentage_24h_usd =
            "market_cap_change_percentage_24h_usd"
        case updated_at = "updated_at"
    }
}
