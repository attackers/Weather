//
//  ZADDHttpServiceManage.swift
//  ZADD
//
//  Created by ZZCM on 2018/12/10.
//  Copyright © 2018 ZZCM. All rights reserved.
//

import UIKit
import Moya
extension ZADDHttpAPIEnum {
    var task: Task {
        switch self {
            
        case .getTodayHistory(_):

            return .requestParameters(parameters:[:], encoding: URLEncoding.queryString)
            
        case .getLocalCoordinate(_):
            return .requestParameters(parameters:[:], encoding: URLEncoding.queryString)
        }
    }
   
}
