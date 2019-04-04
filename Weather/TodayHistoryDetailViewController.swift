//
//  TodayHistoryDetailViewController.swift
//  Weather
//
//  Created by lifu on 2019/4/1.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
class TodayHistoryDetailViewController: UIViewController {
    let pManager = ProjectBusinessManager()
    var uid: String?
    let backImage = UIImageView()
    let contentTextView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
        let leftItem = UIBarButtonItem(image: UIImage(named: "zadd_navigation_left_btn"), style: .done, target: self, action: #selector(goback))
        self.navigationItem.leftBarButtonItem =  leftItem
        
        backImage.contentMode = .scaleAspectFit
        backImage.layer.masksToBounds = true
        view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        contentTextView.isEditable = false
        contentTextView.backgroundColor = UIColor.clear
        contentTextView.font = UIFont(name: "DIN-Black", size: 19)
        contentTextView.textColor = UIColor.orange
        view.addSubview(contentTextView)
        
        contentTextView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 90, left: 10, bottom: 10, right: 10))
        }
        
        
        pManager.getTodayHistoryDetail(uid: uid!, success: { (json) in
            let info = json.array?.first?.dictionary
            
            DispatchQueue.main.async {
                self.title = info!["title"]?.string
                self.contentTextView.text = info!["content"]?.string
            }
            
            let picURL = info!["pic"]?.stringValue
            
            self.backImage.sd_setImage(with: URL(string: picURL!), completed: { (img, error, type, url) in
                DispatchQueue.main.async {
                    self.backImage.image = img

                }
            })
            
        }) { (error) in
            
        }
    }
    
    @objc func goback() {
        self.navigationController?.popViewController(animated: true)
    }

}
