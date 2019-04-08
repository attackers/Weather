//
//  ZADDHttpAPIEnum.swift
//  ZADD
//
//  Created by ZZCM on 2018/12/10.
//  Copyright © 2018 ZZCM. All rights reserved.
//

import UIKit

enum HttpAPIEnum {
    case getWeather(_ city:String)
    case getTodayHistory(_ month: String,_ day: String)
    case getTodayHistoryDetail(_ id: String)
    case getDataURL
}
