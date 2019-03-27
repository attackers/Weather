//
//  ZADDHttpSettings.swift
//  ZADD
//
//  Created by ZZCM on 2018/12/10.
//  Copyright © 2018 ZZCM. All rights reserved.
//

import UIKit
import Moya

let hostURL = "https://qn.kxdati.cn"


extension ZADDHttpAPIEnum: TargetType {
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type":"application/json"]

        }
    }
    
    var baseURL: URL {
            return URL(string: hostURL)!
    }
    var path: String {
        return ""
//
//        switch self {
//
//        }
    }
    
    var method: Moya.Method {
            return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
   
    
}
