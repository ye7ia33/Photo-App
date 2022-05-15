//
//  Repo.swift
//  Created by Yahia El-Dow
//  Copyright © Yahia El-Dow. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol NetworkDelegate {
    func didFeatchData(result: Any)
    func errorResponse(withErrorMessage: String?)
}

class Repo {
    var delegate: NetworkDelegate!
    
    init(delegate: NetworkDelegate) {
        self.delegate = delegate
    }

    func handelRequest<T: Decodable>(_ type: T.Type, response: Any?) {
        let jsonResponse =  JSON(response ?? "")
        guard let model = CodableHandler.shared.decode(type.self, jsonData: jsonResponse) as? T else {
            self.delegate.errorResponse(withErrorMessage: "Parse.Error")
            return
        }
        self.delegate.didFeatchData(result: model)
        return
    }
    
    func handelErrorMessage(response: Any?, errMsg: String?) {
        if let msg = JSON(response ?? "")["message"].string {
            self.delegate.errorResponse(withErrorMessage: msg)
            return
        }
        let msg = errMsg?.isEmpty ?? true ? "هناك خطاء. برجاء المحاوله مره اخري" : errMsg
        self.delegate.errorResponse(withErrorMessage: msg )
    }
}
