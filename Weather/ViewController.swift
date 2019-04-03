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
    @IBOutlet weak var rightItem: UIBarButtonItem!
    let pManager = ProjectBusinessManager()
    var wModel: WeatherModel?
    var historyList = [TodayHistoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTodayHistory()
        requestHttp()
        let dStg = NSDate.date(toString: Date())?.components(separatedBy: " ")
        self.rightItem.title = dStg?.first
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

        let w = (SCREENWIDTH)/5
        for i in 0..<5 {
            let fView = FiveDayWeatherView(frame: CGRect(x: CGFloat(i) * w, y: FiveDayWeather.frame.minY, width: w, height: FiveDayWeather.frame.height))
            self.view.addSubview(fView)
            fView.setContent(model: fList[i])
            if i == 4 {
               fView.line.isHidden = true
            }
        }
    }
    
    func requestHttp()  {
        pManager.getWeather(city: "深圳", success: { (json) in
            self.wModel = WeatherModel(result: json)
            let img =   self.retureBackImageKey(self.wModel!.info!)
            DispatchQueue.main.async {
                self.weatherImageView.image = UIImage(named: img)
                let m = self.wModel?.future.first
                self.title = m?.weather
                self.weatherImageView.image = UIImage(named: self.retureBackImageKey((m?.weather)!))
                self.setupFiveDayWeather(fList: (self.wModel?.future)!)
            }
            
        }) { (error) in
            self.view.makeToast(error as? String)
        }
        let dStg = NSDate.date(toString: Date())?.components(separatedBy: " ")
        let tStg = dStg?.first?.components(separatedBy: "-")
        
        pManager.getTodayHistory(month: tStg![1], day: tStg![2],  success: { (json) in
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let m = historyList[indexPath.row]
        let uid = m.id
        let tDetail = TodayHistoryDetailViewController()
        tDetail.uid = uid
        self.navigationController?.pushViewController(tDetail, animated: true)
    }
    
}
