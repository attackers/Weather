//
//  FiveDayWeatherView.swift
//  Weather
//
//  Created by ZZCM on 2019/3/28.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit

class FiveDayWeatherView: UIView {
    let iconImageView = UIImageView()
    let wLabel = UILabel()
    let dateLabel = UILabel()
    let tLabel = UILabel()
    let line = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setSubViewSnp()
        setSubProperty()
    }
    
    func addSubView()  {
        addSubview(iconImageView)
        addSubview(wLabel)
        addSubview(dateLabel)
        addSubview(tLabel)
        addSubview(line)

    }
    
    func setSubViewSnp()  {
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(0)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(30)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom)
            $0.left.equalTo(0)
            $0.height.equalTo(20)
            $0.width.equalTo(self.snp.width)
        }
        
        wLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.left.equalTo(0)
            $0.height.equalTo(20)
            $0.width.equalTo(self.snp.width)
        }
 
        tLabel.snp.makeConstraints {
            $0.top.equalTo(wLabel.snp.bottom)
            $0.left.equalTo(0)
            $0.height.equalTo(20)
            $0.width.equalTo(self.snp.width)
        }
        line.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.right.equalTo(-1)
            $0.height.equalTo(self.snp.height)
            $0.width.equalTo(1)
        }
    }
    
    func setSubProperty()  {
        
        iconImageView.contentMode = .scaleAspectFit
        
        dateLabel.font = UIFont(name: "DIN-BoldAlternate", size: 13)
        dateLabel.textColor = UIColor("#07090C")
        dateLabel.textAlignment = .center
        dateLabel.text = "3.27"
        
        wLabel.font = UIFont(name: "DIN-BoldAlternate", size: 13)
        wLabel.textColor = UIColor("#07090C")
        wLabel.text = "晴"
        wLabel.textAlignment = .center
        
        tLabel.font = UIFont(name: "DIN-BoldAlternate", size: 13)
        tLabel.textColor = UIColor("#07090C")
        tLabel.text = "深圳"
        tLabel.textAlignment = .center

        line.backgroundColor = UIColor.groupTableViewBackground
    }
    func setContent(model: FutureModel) {
        let wStg = model.weather?.components(separatedBy: "转")
        let index = (weatherIcons as NSArray).index(of: wStg?.last as Any)
        let stg = String(format: "http://www.weather.com.cn/m/i/icon_weather/42x30/d%02d.gif",index)
        iconImageView.sd_setImage(with: URL(string: stg)) { (img, error, type, url) in
            DispatchQueue.main.async {
                self.iconImageView.image = img
            }
        }
        wLabel.text = model.weather
        dateLabel.text = model.date
        tLabel.text = model.temperature        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
