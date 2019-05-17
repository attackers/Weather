//
//  ViewController.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import SDWebImage
import Toast_Swift
import MapKit
class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var FiveDayWeather: UIStackView!
    @IBOutlet weak var todayHistory: UITableView!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    @IBOutlet weak var leftItem: UIBarButtonItem!
    let pManager = ProjectBusinessManager()
    var wModel: WeatherModel?
    var historyList = [TodayHistoryModel]()
    let sam = DispatchSemaphore(value: 1)
    let group = DispatchGroup()
    let queue = DispatchQueue.init(label: "semaphore")
    let model = LocationManager()
    var city = "深圳"
    var location2D: CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTodayHistory()
        requestHttp()
        getLocationAuther()
        
        let dStg = NSDate.date(toString: Date())?.components(separatedBy: " ")
        self.rightItem.title = dStg?.first
        UserCurrentModel.share.date = dStg!.first!

    }
    
    func setupTodayHistory()  {
        todayHistory.delegate = self
        todayHistory.dataSource = self
        todayHistory.register(TodayHistoryTableViewCell.self, forCellReuseIdentifier: "TodayHistoryTableViewCell")
        todayHistory.layer.cornerRadius = 16
        todayHistory.layer.masksToBounds = true
        FiveDayWeather.distribution = .fillProportionally
    }
    
    func setupFiveDayWeather(fList: [FutureModel])  {
        for i in 0..<5 {
            let v = self.view.viewWithTag(1000 + i)
            v?.removeFromSuperview()
        }
        
        let w = (SCREENWIDTH)/5
        for i in 0..<5 {
            let fView = FiveDayWeatherView(frame: CGRect(x: CGFloat(i) * w, y: FiveDayWeather.frame.minY, width: w, height: FiveDayWeather.frame.height))
            self.view.addSubview(fView)
            fView.setContent(model: fList[i])
            fView.tag = 1000 + i
            if i == 4 {
               fView.line.isHidden = true
            }
        }
    }
    
    func requestHttp()  {
        UserCurrentModel.share.city = self.city
        queue.async(group: group, qos: DispatchQoS.default, flags: []) {
            self.sam.wait()
            self.pManager.getWeather(city: self.city, success: { (json) in
                self.wModel = WeatherModel(result: json)
                let img = self.retureBackImageKey(self.wModel!.info!)
                DispatchQueue.main.async {
                    self.weatherImageView.image = UIImage(named: img)
                    let m = self.wModel?.future.first
                    self.title = m?.weather
                    UserCurrentModel.share.weather = (m?.weather)!
                    self.weatherImageView.image = UIImage(named: self.retureBackImageKey((m?.weather)!))
                    self.setupFiveDayWeather(fList: (self.wModel?.future)!)
                }
                self.sam.signal()
                print("一次执行")

            }) { (error) in
                self.view.makeToast(error as? String)
                self.sam.signal()
            }
        }
       
        queue.async(group: group, qos: DispatchQoS.default, flags: []) {
            self.sam.wait()
            print("二次等待执行开始")
            let dStg = NSDate.date(toString: Date())?.components(separatedBy: " ")
            let tStg = dStg?.first?.components(separatedBy: "-")
            
            self.pManager.getTodayHistory(month: tStg![1], day: tStg![2],  success: { (json) in
                let list = json.array
                _ = list?.map({ (objc)in
                    let hModel = TodayHistoryModel(result: objc)
                    self.historyList.append(hModel)
                })
                DispatchQueue.main.async {
                    self.todayHistory.reloadData()
                }
                self.sam.signal()
            }) { (error) in
                self.sam.signal()
            }
        }
        
    }
    
    func retureBackImageKey(_ key: String) -> String {
        if key.contains("晴") {
            return "晴天"
        } else if key.contains("雨") {
            return "下雨"

        } else if key.contains("雪") {
            return "下雪"
            
        } else if key.contains("风") {
            return "台风"
            
        } else {
            return "阴天"
        }
    }
    
    fileprivate func getLocationAuther() {
        model.locationBlock = { city,location2D  in
            DispatchQueue.main.async {
                self.leftItem.title = city
                self.city = city
                self.location2D = location2D
            }
        }
        switch model.getLocationStatus() {
        case .denied,.restricted:
            let aler = UIAlertController(title: nil, message: "点滴生活需要使用您的定位功能，是否开启", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "好的", style: .default) { (_) in
                if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
                    UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
            let action2 = UIAlertAction(title: "取消", style: .default) { (_) in}
            aler.addAction(action1)
            aler.addAction(action2)
            self.present(aler, animated: true, completion: nil)
        default:break
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination
        if sVC.classForCoder == AddressViewController.classForCoder() {
            let aVC = sVC as! AddressViewController
            aVC.delegate = self
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource,ProjectDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayHistoryTableViewCell") as! TodayHistoryTableViewCell
        let m = historyList[indexPath.row]
        cell.dateLabel.text = m.title
        cell.titleLabel.text = String(format: "%@/%@/%@", m.year!,m.month!,m.day!)
        cell.contentLabel.text = m.des
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let m = historyList[indexPath.row]
        let tVC = TodayHistoryDetailViewController()
        tVC.uid = m.id
        self.navigationController?.pushViewController(tVC, animated: true)
    }
    func didSelectCity(city: String) {
        
        self.city = city
        if self.city.hasSuffix("市") {
            let i = self.city.index(of: "市")
            let obj = self.city[city.startIndex..<i!]
            self.city = String(obj)
            print(self.city)
        }
        self.leftItem.title = city
        requestHttp()
    }
}
