//
//  HelperClass.swift
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import Foundation

func dLog(_ val: Any?){
    #if DEBUG
       print(val ?? "PARAMTERS IS NULL")
    #endif
}
