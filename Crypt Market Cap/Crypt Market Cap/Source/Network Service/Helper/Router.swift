//
//  Router.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 05/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import Foundation
import Alamofire

enum Router : URLRequestConvertible{
    static let baseURL = "https://api.coinmarketcap.com/v1/ticker" // staging dns
    case requestAll()
    case requestWith(Int)
    case requestConvert(String,Int,Int)

    
    var method : Alamofire.HTTPMethod{
        switch self {
        case .requestAll():
            return .get
            
        case .requestWith(_):
            return .get
            
        case .requestConvert(_,_,_):
            return .get
        }
        
    }
    
    var path : String{
        switch self {
        case .requestAll():
            return ("")
        case .requestWith(let limit):
            return ("/?limit=\(limit)")
        case .requestConvert(let convert, let start, let limit):
            return ("/?convert=\(convert)&start=\(start)&limit=\(limit)")
        }
    }
    
    func asURLRequest() throws -> URLRequest
    {
        let url = URL(string: Router.baseURL + path)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .requestAll():
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)

        case .requestConvert(_,_,_):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)

        case .requestWith(_):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)

        }

    }
}

