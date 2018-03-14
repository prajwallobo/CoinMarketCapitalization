//
//  Coin.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 05/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import UIKit
import ObjectMapper

class Coin: BaseModel {

    var identifer : String!
    var name : String!
    var symbol : String!
    var rank :  String!
    var priceUSD : String!
    var priceBTC : String!
    var priceINR : String?
    var volume24USD : String!
    var marketCapUSD : String!
    var availableSupply : String!
    var totalSupply : String!
    var percentChange1Hour : String!
    var percentChange24Hour : String!
    var percentChange7Days : String!
    var timestamp : String!
    
    override func mapping(map : Map){
        identifer <- map["id"]
        name <- map["name"]
        symbol <- map["symbol"]
        rank <- map["rank"]
        priceUSD <- map["price_usd"]
        priceBTC <- map["price_btc"]
        priceINR <- map["price_inr"]
        volume24USD <- map["24h_volume_usd"]
        marketCapUSD <- map["market_cap_usd"]
        availableSupply <- map["available_supply"]
        totalSupply <- map["total_supply"]
        percentChange1Hour <- map["percent_change_1h"]
        percentChange24Hour <- map["percent_change_24h"]
        percentChange7Days <- map["percent_change_7d"]
        timestamp <- map["last_updated"]
    }
    
    
}
