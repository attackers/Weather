//
//  DiaryViewController.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {

    @IBOutlet weak var diaryListTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryListTableview.delegate = self
        diaryListTableview.dataSource = self
        diaryListTableview.register(DiaryTableViewCell.self, forCellReuseIdentifier: "DiaryTableViewCell")
    }
    
}
extension DiaryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryTableViewCell") as! DiaryTableViewCell
        return cell
    }
   
    
}
