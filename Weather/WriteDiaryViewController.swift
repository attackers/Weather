//
//  WriteDiaryViewController.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var writeTextView: UITextView!
    var cInfo: [String: String]?
    var objIndex: NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = UIColor.groupTableViewBackground
        writeTextView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        writeTextView.layer.borderWidth = 1
        writeTextView.layer.masksToBounds = true
        writeTextView.layer.cornerRadius = 8
        writeTextView.becomeFirstResponder()
        writeTextView.delegate = self
        guard cInfo != nil else {
            addressLabel.text = UserCurrentModel.share.city
            weatherLabel.text = UserCurrentModel.share.weather
            dateLabel.text = UserCurrentModel.share.date
            return
        }
        addressLabel.text = cInfo!["city"]
        weatherLabel.text = cInfo!["weather"]
        dateLabel.text = cInfo!["date"]
        writeTextView.text = cInfo!["content"]
  
    }
    
    @IBAction func saveWriteItem(_ sender: Any) {
        
        
        
        let setInfoValue = ["content": writeTextView.text,
                            "date": dateLabel.text,
                            "weather": weatherLabel.text,
                            "city": addressLabel.text] as! [String: String]
        if cInfo != nil {
            ProjectBusinessManager().setObjcUserDiary(obj: setInfoValue,replace: true,objIndex!)
        }else {
            ProjectBusinessManager().setObjcUserDiary(obj: setInfoValue,replace: false)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backItem(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
    }
}
