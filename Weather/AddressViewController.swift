//
//  AddressViewController.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import MapKit
class AddressViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var list:NSDictionary?
    var city: String?
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "zadd_cityTree.plist", ofType: "")
        list = NSDictionary(contentsOfFile: path!)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellSelf")
        self.title = "城市"
    }
    @IBAction func backItem(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    
}
extension AddressViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (list?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = list?.allKeys[section]  as! String
        let info = list![key] as? NSArray
        let l = info?.firstObject as? NSDictionary
        return (l?.allKeys.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "UITableViewCellSelf")
        let key = list?.allKeys[indexPath.section]  as! String
        let info = list![key] as! NSArray
        let l = info.firstObject as? NSDictionary
        let k  = l?.allKeys[indexPath.row] as! String
        cell?.textLabel?.text = k
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH - 18, height: 36))
        let label = UILabel(frame: CGRect(x: 18, y: 0, width: SCREENWIDTH - 18, height: 36))
        let key = list?.allKeys[section]  as! String
        label.text = key
        label.font = UIFont(name: "DIN-BlackAlternate", size: 19)
        v.addSubview(label)
        return v
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = list?.allKeys[indexPath.section]  as! String
        let info = list![key] as! NSArray
        let l = info.firstObject as? NSDictionary
        let k  = l?.allKeys[indexPath.row] as! String
        city = k
        self.navigationController?.popViewController(animated: true)
    }
}
