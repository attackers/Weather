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

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var FiveDayWeather: UIStackView!
    @IBOutlet weak var todayHistory: UITableView!
    
    let pManager = ProjectBusinessManager()
    var wModel: WeatherModel?
    var historyList = [TodayHistoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFiveDayWeather()
        setupTodayHistory()
        requestHttp()
    }
    
    func setupTodayHistory()  {
        todayHistory.delegate = self
        todayHistory.dataSource = self
        todayHistory.register(TodayHistoryTableViewCell.self, forCellReuseIdentifier: "TodayHistoryTableViewCell")
        todayHistory.layer.cornerRadius = 16
        todayHistory.layer.masksToBounds = true
        FiveDayWeather.distribution = .fillProportionally
    }
    
    func setupFiveDayWeather()  {

        let w = (SCREENWIDTH - 60)/5
        var x:CGFloat = 10.0
        for i in 0..<5 {
            let fView = FiveDayWeatherView(frame: CGRect(x: CGFloat(x), y: FiveDayWeather.frame.minY, width: w, height: FiveDayWeather.frame.height))
            self.view.addSubview(fView)
            if i == 4 {
               fView.line.isHidden = true
            }
            x = x + CGFloat(fView.frame.width) + 10.0
        }

    }
    
    func requestHttp()  {
        pManager.getWeather(city: "深圳", success: { (json) in
            self.wModel = WeatherModel(result: json)
            let img =   self.retureBackImageKey(self.wModel!.info!)
            DispatchQueue.main.async {
                self.weatherImageView.image = UIImage(named: img)
                self.title = self.wModel!.info!
            }
            let index = (weatherIcons as NSArray).index(of: "小雪")
            
        }) { (error) in
            self.view.makeToast(error as? String)
        }
        
        pManager.getTodayHistory(month: "3", day: "29",  success: { (json) in
            let list = json.array
            _ = list?.map({ (objc)in
                let hModel = TodayHistoryModel(result: objc)
                self.historyList.append(hModel)
            })
            DispatchQueue.main.async {
                self.todayHistory.reloadData()
            }
        }) { (error) in
            
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
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
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
    
    
}
