//
//  APIService.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 05/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class APIService: NSObject {
    static let shared = APIService()
    
    func getAllCryptoCoins(withCompletionHandler handler: @escaping([Coin]?, ServerError?) ->Void){
        Alamofire.request(Router.requestAll()).validate().responseArray(queue: .main, keyPath: nil, context: nil) { (response : DataResponse<[Coin]>) in
            if response.result.isFailure{
                if let error = response.result.error{
                    let serverObject = self.getErrorObject(from: error)
                        handler(nil,serverObject)
                }
            
            }else{
                if let coin = response.result.value{
                    handler(coin,nil)
                    print("Fetched coins : \(coin)")
                }else{
                    handler(nil,nil)
                }
            }
            
        }
    }
    
    func getCryptoWith(currency type : String, start : Int, limit : Int, withCompletionHandler handler: @escaping([Coin]?, ServerError?) ->Void){
        Alamofire.request(Router.requestConvert(type, start, limit)).validate().responseArray(queue: .main, keyPath: nil, context: nil) { (response : DataResponse<[Coin]>) in
            if response.result.isFailure{
                if let error = response.result.error{
                    let serverObject = self.getErrorObject(from: error)
                    handler(nil,serverObject)
                }
                
            }else{
                if let coin = response.result.value{
                    handler(coin,nil)
                    print("Fetched coins : \(coin)")
                }else{
                    handler(nil,nil)
                }
            }
            
        }
    }
    
    func getErrorObject(from error : Error) -> ServerError{
        let serverError = ServerError()
            serverError.code = 400
            serverError.message = error.localizedDescription
            return serverError
    }
}
        





