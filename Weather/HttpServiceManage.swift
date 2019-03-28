//
//  ZADDHttpServiceManage.swift
//  ZADD
//
//  Created by ZZCM on 2018/12/10.
//  Copyright © 2018 ZZCM. All rights reserved.
//

import UIKit
import Moya
extension HttpAPIEnum {
    var task: Task {
        switch self {
        case .getTodayHistory(let month,let day):
            let parameters = ["key":juheHistoryTodayKey,"month":month,"day":day,"v":"1.0"]
            return .requestParameters(parameters:parameters, encoding: URLEncoding.queryString)
        case .getTodayHistoryDetail(let e_id):
            let parameters = ["key":juheHistoryTodayKey,"id":e_id,"v":"1.0"]
            return .requestParameters(parameters:parameters, encoding: URLEncoding.queryString)
        case .getWeather(let city):
            let parameters = ["key":juheWentherKey,"city":city]
            return .requestParameters(parameters:parameters, encoding: URLEncoding.queryString)
        }
    }
   
}
