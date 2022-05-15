//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import Foundation
import SwiftyJSON

class PhotoService: Repo {
    
    func getRemoteData() {
        let url = "https://jsonplaceholder.typicode.com/photos"
        AFN.request(requestURL: url, httpMethod: .get) { (response, statusCode, errMsg) in
            if statusCode == 200 {
                self.handelRequest(PhotoArrayList.self, response: response)
            } else {
                self.handelErrorMessage(response: response, errMsg: errMsg)
            }
        }
    }
}
