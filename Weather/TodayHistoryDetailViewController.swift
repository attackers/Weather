//
//  TodayHistoryDetailViewController.swift
//  Weather
//
//  Created by lifu on 2019/4/1.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit

class TodayHistoryDetailViewController: UIViewController {
    let pManager = ProjectBusinessManager()
    var uid: String?
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        pManager.getTodayHistoryDetail(uid: uid!, success: { (json) in
            let list = json.array
            
        }) { (error) in
            
        }
    }
    


}
