//
//  ProjectClassModel.swift
//  Weather
//
//  Created by ZZCM on 2019/3/28.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Wid {
    var day: String?
    var night: String?
}
struct FutureModel {
    var date: String?
    var temperature: String?
    var weather: String?
    var wid: Wid?
    var direct: String?
    init(future: JSON) {
        date = future["date"].stringValue
        temperature = future["temperature"].stringValue
        weather = future["weather"].stringValue
        let wObjc = future["wid"].dictionaryValue
        wid =  Wid.init(day: wObjc["day"]?.stringValue, night: wObjc["night"]?.stringValue)
    }
}

struct WeatherModel {
    var temperature: String?
    var humidity: String?
    var info: String?
    var wid: String?
    var direct: String?
    var power: String?
    var aqi: String?
    var future = [FutureModel]()
    init(result: JSON) {
        let realtime = result["realtime"].dictionaryValue
        temperature = realtime["temperature"]!.stringValue
        humidity = realtime["humidity"]!.stringValue
        info = realtime["info"]!.stringValue
        wid = realtime["wid"]!.stringValue
        direct = realtime["direct"]!.stringValue
        aqi = realtime["aqi"]!.stringValue
        let listFuture = result["future"].arrayValue
        _ = listFuture.map({ (json)   in
            let fObjc = FutureModel.init(future: json)
            future.append(fObjc)
        })
    }
}
struct TodayHistoryModel {
    var day: String?
    var year: String?
    var month: String?
    var des: String?
    var title: String?
    var id: String?
    var pic: String?
    init(result: JSON) {
        day = result["day"].stringValue
        year = result["year"].stringValue
        month = result["month"].stringValue
        des = result["des"].stringValue
        title = result["title"].stringValue
        id = result["_id"].stringValue
        pic = result["pic"].stringValue
    }
}

class UserCurrentModel: NSObject {
    static let share = UserCurrentModel()
    var city = ""
    var date = ""
    var weather = ""
    
    override init() {
        super.init()
    }
}
