//
//  Header.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

let juheHistoryTodayKey = "6e91d3944b9a1f6816706bd8e06acc9e"
let juheWentherKey = "39b0d147efe0f6cbe7c8b88f5bf030a1"
/// UIScreen宽度
let SCREENWIDTH = UIScreen.main.bounds.width
/// UIScreen高度
let SCREENHEIGHT = UIScreen.main.bounds.height

let DIARYKEY = "userDiary"

typealias Success = (_ response: JSON)->Void
typealias Fail = (_ error: Any)->Void

typealias FinishSuccess = (_ response: Any)->Void
typealias FinishFail = (_ error: Any)->Void
let weatherIcons = ["晴","多云","阴","阵雨","雷阵雨","雷阵雨伴有冰雹","雨夹雪","小雨","中雨","大雨","暴雨","大暴雨","特大暴雨","阵雪","小雪","中雪","大雪","暴雪","雾","冻雨","沙尘暴","小雨-中雨","中雨-大雨","大雨-暴雨","暴雨-大暴雨","大暴雨-特大暴雨","小雪-中雪","中雪-大雪","大雪-暴雪","浮尘","扬沙","强沙尘暴","霾"]
