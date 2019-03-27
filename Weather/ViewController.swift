//
//  ViewController.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var FiveDayWeather: UIStackView!
    @IBOutlet weak var todayHistory: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        todayHistory.delegate = self
        todayHistory.dataSource = self
        todayHistory.register(TodayHistoryTableViewCell.self, forCellReuseIdentifier: "TodayHistoryTableViewCell")
        todayHistory.layer.cornerRadius = 16
        todayHistory.layer.masksToBounds = true
        FiveDayWeather.distribution = .fillProportionally
       
        for i in 0..<5 {
            let w:Int = Int(FiveDayWeather.frame.width/5)
            let button = BeeCustomButton()
            button.type = .type_textOnBottom_IconOnTop
            button.setTitle("晴\n3.27", for: .normal)
            button.titleLabel?.numberOfLines = 2
            
            let url = URL(string: String(format: "%@d%02d.gif", wenther1,i))
            button.sd_setBackgroundImage(with: url, for: .normal, placeholderImage: UIImage(), options: .avoidAutoSetImage) { (img, error, ty, url) in
                button.setImage(img, for: .normal)
            }
            button.frame = CGRect(x: i * w, y: 0, width: w, height: 100)
            FiveDayWeather.addSubview(button)
        }
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayHistoryTableViewCell") as! TodayHistoryTableViewCell
        return cell
    }
    
    
}
