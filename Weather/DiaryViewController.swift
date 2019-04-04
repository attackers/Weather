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
    var list = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryListTableview.delegate = self
        diaryListTableview.dataSource = self
        diaryListTableview.separatorStyle = .none
        diaryListTableview.register(DiaryTableViewCell.self, forCellReuseIdentifier: "DiaryTableViewCell")
        diaryListTableview.tableFooterView = UIView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        list = ProjectBusinessManager().getUserDiary()
        diaryListTableview.reloadData()
    }
    @IBAction func backItem(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension DiaryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryTableViewCell") as! DiaryTableViewCell
        let objc = list[indexPath.row] as? [String: String]
        cell.addressLabel.text = objc!["city"]
        cell.weatherLabel.text = objc!["weather"]
        cell.dateLabel.text = objc!["date"]
        cell.contentLabel.text = objc!["content"]
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell!.setSelected(false, animated: false)
        let objc = list[indexPath.row] as? [String: String]
        let story = UIStoryboard(name: "Main", bundle: nil)
        let wVC = story.instantiateViewController(withIdentifier: "WriteDiaryViewController") as! WriteDiaryViewController
        wVC.cInfo = objc
        wVC.objIndex = indexPath.row
        self.navigationController?.pushViewController(wVC, animated: true)
        
    }
    
}
