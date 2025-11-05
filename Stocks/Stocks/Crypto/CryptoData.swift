//
//  CryptoData.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 7/7/21.
//

import SwiftUI

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)



// MARK: - Welcome
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - CryptoData
struct CryptoData: Codable, Identifiable {
    let id, currency, symbol, name: String
    let logoURL: String
    let status: Status
    let price: String
    let priceDate, priceTimestamp: Date
    let circulatingSupply: String
    let maxSupply: String?
    let marketCap, marketCapDominance, numExchanges, numPairs: String
    let numPairsUnmapped: String
    let firstCandle: Date
    let firstTrade, firstOrderBook: Date?
    let rank, rankDelta, high: String
    let highTimestamp: Date
    let the1D, the30D: The1_D
    let firstPricedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, currency, symbol, name
        case logoURL = "logo_url"
        case status, price
        case priceDate = "price_date"
        case priceTimestamp = "price_timestamp"
        case circulatingSupply = "circulating_supply"
        case maxSupply = "max_supply"
        case marketCap = "market_cap"
        case marketCapDominance = "market_cap_dominance"
        case numExchanges = "num_exchanges"
        case numPairs = "num_pairs"
        case numPairsUnmapped = "num_pairs_unmapped"
        case firstCandle = "first_candle"
        case firstTrade = "first_trade"
        case firstOrderBook = "first_order_book"
        case rank
        case rankDelta = "rank_delta"
        case high
        case highTimestamp = "high_timestamp"
        case the1D = "1d"
        case the30D = "30d"
        case firstPricedAt = "first_priced_at"
    }
}

enum Status: String, Codable {
    case active = "active"
}

// MARK: - The1_D
struct The1_D: Codable {
    let volume, priceChange, priceChangePct, volumeChange: String
    let volumeChangePct: String
    let marketCapChange, marketCapChangePct: String?

    enum CodingKeys: String, CodingKey {
        case volume
        case priceChange = "price_change"
        case priceChangePct = "price_change_pct"
        case volumeChange = "volume_change"
        case volumeChangePct = "volume_change_pct"
        case marketCapChange = "market_cap_change"
        case marketCapChangePct = "market_cap_change_pct"
    }
}

typealias Crypto = [CryptoData]


class Api {
    func getPosts(completion: @escaping([CryptoData]) -> ()) {
        guard let url = URL(string: "https://api.nomics.com/v1/currencies/ticker?key=3fad5462303f05f24f5d679f2e2f16e1339b446d&interval=1d,30d&convert=USD&per-page=1000") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let decoder = JSONDecoder()
                       decoder.dateDecodingStrategy = .iso8601
                       do {
                           let coins = try decoder.decode([CryptoData].self, from: data!)
                        DispatchQueue.main.async {
                            completion(coins)
                        }
                       } catch {
                           print(error)
                           //add some better error handling here
                       }
           
        }
        .resume()
    }
}
