//
//  ProjectBusinessManager.swift
//  Weather
//
//  Created by ZZCM on 2019/3/28.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class ProjectBusinessManager: NSObject {
    let provider = MoyaProvider<HttpAPIEnum>()
    func getWeather(city: String,success: @escaping  Success,Fail fail: @escaping Fail) {
        provider.request(.getWeather(city)) {
            switch $0 {
            case .failure(let error):
                fail(error.errorDescription as Any)
            case .success(let response):
                let json = JSON(response.data)
                let code = json["error_code"].stringValue
                if code == "0" {
                    let result = json["result"]
                    success(result)
                } else {
                    let reason = json["reason"].stringValue
                    fail(reason)
                }
                print(json)
            }
        }
    }
    func getTodayHistory(month: String,day:String,success: @escaping  Success,Fail fail: @escaping Fail)  {
        provider.request(.getTodayHistory(month, day)) {
            switch $0 {
            case .failure(let error):
                fail(error.errorDescription as Any)
            case .success(let response):
                let json = JSON(response.data)
                let code = json["error_code"].stringValue
                if code == "0" {
                    let result = json["result"]
                    success(result)
                } else {
                    let reason = json["reason"].stringValue
                    fail(reason)
                }
//                print(json)
            }
        }
    }
    
    func getTodayHistoryDetail(uid: String,success: @escaping  Success,Fail fail: @escaping Fail)  {
        provider.request(.getTodayHistoryDetail(uid)) {
            switch $0 {
            case .failure(let error):
                fail(error.errorDescription as Any)
            case .success(let response):
                let json = JSON(response.data)
                let code = json["error_code"].stringValue
                if code == "0" {
                    let result = json["result"]
                    success(result)
                } else {
                    let reason = json["reason"].stringValue
                    fail(reason)
                }
                print(json)
            }
        }
    }
    
    func  getUserDiary() -> [Any] {
        guard let list = UserDefaults.standard.array(forKey: DIARYKEY) else {
            return []
        }
        
        return list
    }
    func setObjcUserDiary(obj: [String: String],replace: Bool,_ index: NSInteger = 0) {
        guard var uDe = UserDefaults.standard.array(forKey: DIARYKEY) else {
            UserDefaults.standard.set([obj], forKey: DIARYKEY)
            return
        }
        if replace {
            uDe[index] = obj
        } else {
            uDe.append(obj)
        }
        UserDefaults.standard.set(uDe, forKey: DIARYKEY)
    }
    func getProjectDataURL(success: @escaping  Success,Fail fail: @escaping Fail) {
        provider.request(.getDataURL) {
            switch $0 {
            case .failure(let error):
                fail(error.errorDescription as Any)
            case .success(let response):
                let json = JSON(response.data)
                let code = json["rt_code"].stringValue
                if code == "200" {
                    do {
                        let result = json["data"].stringValue
                        let n = NSData(base64Encoded: result, options: NSData.Base64DecodingOptions.init(rawValue: 0))
                        let j = try? JSONSerialization.jsonObject(with: n! as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                        let dic = j as! [String: String]
                        let jObjc = JSON.init(dic)
                        MainModel.share.url = dic["url"] as? String
                        MainModel.share.show_url = dic["show_url"] as? String
                        success(jObjc)
                        return
                    }catch {
                        
                    }
                    fail("error")
                } else {
                    let reason = json["rt_code"].stringValue
                    fail(reason)
                }
                print(json)
            }
        }
    }
    
}

protocol ProjectDelegate {
    func didSelectCity(city: String)
}
extension ProjectDelegate {
    func didSelectCity(city: String) {}
}
