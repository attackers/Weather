//
//  ZADDHttpSettings.swift
//  ZADD
//
//  Created by ZZCM on 2018/12/10.
//  Copyright © 2018 ZZCM. All rights reserved.
//

import UIKit
import Moya

let todayHistoryURL = "http://api.juheapi.com/japi/toh"
let weatherURL = "http://apis.juhe.cn/"

extension HttpAPIEnum: TargetType {
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type":"application/json"]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getTodayHistory(_):
            return URL(string: todayHistoryURL)!
        case .getTodayHistoryDetail(_):
            return URL(string: "http://api.juheapi.com/japi/tohdet")!
        case .getWeather(_):
            return URL(string: weatherURL)!

        }
    }
    var path: String {
        switch self {
        case .getTodayHistory(_):
            return ""
        case .getTodayHistoryDetail(_):
            return ""
        case .getWeather(_):
            return "simpleWeather/query"
        }
    }
    
    var method: Moya.Method {
        
//        switch self {
//        case .getTodayHistory(_):
//            return .get
//        case .getTodayHistoryDetail(_):
//            return .get
//        case .getWeather(_):
            return .post
//        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
   
    
}
