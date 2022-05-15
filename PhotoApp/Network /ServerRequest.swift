
//
//  ServerRequest.swift
//  Created by Yahia El-Dow on 6/24/17.
//  Copyright © 2017 Production Code. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// ALAMO FIRE NETWORK
class AFN : NSObject {
    
    fileprivate lazy var urlEncoding = JSONEncoding.default
    fileprivate static var headers: HTTPHeaders = ["Content-Type": "application/json",
                                                   "Accept" : "application/json"]
    class func request (requestURL : String,
                        httpMethod: HTTPMethod = .get ,
                        paramter : [String : Any]? = nil ,
                        Result:@escaping(_ result : Any? ,_ responseCode : Int , _ errorMessage : String?)->()) {
        let urlEncoding = requestURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? requestURL
        AF.request(urlEncoding,
                   method: httpMethod ,
                   parameters: paramter ,
                   encoding:  JSONEncoding.prettyPrinted ,
                   headers: headers )
            .validate(statusCode: 200..<400)
            .responseJSON(completionHandler: {
                response in

                let statusCode = response.response?.statusCode
                switch response.result
                {
                case .failure(let error) :
                    guard let data = response.data, let errorJson = try? JSON(data:data).dictionary else {
                        Result(nil , statusCode ?? 0, "Error")
                        return
                    }
                    
                    let errorMessage = errorJson["message"]?.string ?? error.localizedDescription
                    Result(nil , statusCode ?? 0, errorMessage)
                    return
                    
                case .success(let requestResult):
                    Result(requestResult, statusCode ?? 0, nil)
                    return
                }
            })
    }
    
}
