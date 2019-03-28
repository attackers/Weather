//
//  TodayHistoryTableViewCell.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit

class TodayHistoryTableViewCell: UITableViewCell {
    let dateLabel = UILabel()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubView()
        setSubViewSnp()
        setSubProperty()
    }
    func addSubView()  {
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(contentLabel)
    }
    
    func setSubViewSnp()  {
        dateLabel.snp.makeConstraints {
            $0.top.left.equalTo(10)
            $0.height.equalTo(20)
            $0.width.equalTo(SCREENWIDTH - 180)
        }
   
        titleLabel.snp.makeConstraints {
            $0.right.top.equalTo(10)
            $0.height.equalTo(20)
            $0.width.equalTo(120)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.left.equalTo(10)
            $0.height.equalTo(40)
            $0.width.equalTo(SCREENWIDTH - 60)
        }
    }
    
    func setSubProperty()  {
        self.backgroundColor = UIColor(white: 0.6, alpha: 0.35)
        dateLabel.font = UIFont(name: "DIN-BoldAlternate", size: 17)
        dateLabel.textColor = UIColor("#07090C")
        dateLabel.text = "2019.3.27"
        dateLabel.backgroundColor = UIColor.clear

        titleLabel.font = UIFont(name: "DIN-BoldAlternate", size: 17)
        titleLabel.textColor = UIColor("#07090C")
        titleLabel.text = "深圳"
        titleLabel.backgroundColor = UIColor.clear

        contentLabel.font = UIFont(name: "MicrosoftYaHei", size: 13)
        contentLabel.textColor = UIColor("#07090C")
        contentLabel.numberOfLines = 999
        contentLabel.text = "其实本文写的都是一些再基础不过的内容，在平时阅读一些开源项目的时候经常会遇到一些保持线程同步的方式，因为场景不同可能选型不同，这篇就做一下简单的记录吧~我相信读完这篇你应该能根据不同场景选择合适的锁了吧、能够道出自旋锁和互斥锁的区别了吧。"
        contentLabel.backgroundColor = UIColor.clear

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
