//
//  DiaryTableViewCell.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import SnapKit
import UIColor_Hex_Swift
class DiaryTableViewCell: UITableViewCell {
    
    let dateLabel = UILabel()
    let weatherLabel = UILabel()
    let addressLabel = UILabel()
    let contentLabel = UILabel()
    let shadowLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        setSubViewSnp()
        setSubProperty()
    }
    func addSubView()  {
        addSubview(shadowLabel)
        addSubview(dateLabel)
        addSubview(weatherLabel)
        addSubview(addressLabel)
        addSubview(contentLabel)
    }
    
    func setSubViewSnp()  {
        shadowLabel.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        dateLabel.snp.makeConstraints {
            $0.top.left.equalTo(10)
            $0.height.equalTo(20)
            $0.width.equalTo(90)
        }
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(0)
            $0.height.equalTo(20)
            $0.width.equalTo(SCREENWIDTH)
        }
        addressLabel.snp.makeConstraints {
            $0.right.top.equalTo(10)
            $0.height.equalTo(20)
            $0.width.equalTo(90)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.left.equalTo(10)
            $0.height.equalTo(60)
            $0.width.equalTo(SCREENWIDTH - 20)
        }
    }
    
    func setSubProperty()  {
        shadowLabel.layer.borderWidth = 1
        shadowLabel.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        shadowLabel.layer.cornerRadius = 8
        shadowLabel.layer.shadowOpacity = 1
        shadowLabel.layer.shadowOffset = CGSize(width: 5, height: -5)
        shadowLabel.layer.shadowRadius = 6
        shadowLabel.layer.masksToBounds = true
        
        dateLabel.font = UIFont(name: "DIN-BoldAlternate", size: 13)
        dateLabel.textColor = UIColor("#07090C")
        dateLabel.text = "2019.3.27"
        
        weatherLabel.font = UIFont(name: "DIN-BoldAlternate", size: 13)
        weatherLabel.textColor = UIColor("#07090C")
        weatherLabel.text = "晴"
        weatherLabel.textAlignment = .center
        
        addressLabel.font = UIFont(name: "DIN-BoldAlternate", size: 13)
        addressLabel.textColor = UIColor("#07090C")
        addressLabel.text = "深圳"

        contentLabel.font = UIFont(name: "MicrosoftYaHei", size: 15)
        contentLabel.textColor = UIColor("#07090C")
        contentLabel.numberOfLines = 999
        contentLabel.text = "其实本文写的都是一些再基础不过的内容，在平时阅读一些开源项目的时候经常会遇到一些保持线程同步的方式，因为场景不同可能选型不同，这篇就做一下简单的记录吧~我相信读完这篇你应该能根据不同场景选择合适的锁了吧、能够道出自旋锁和互斥锁的区别了吧。"

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
