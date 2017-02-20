//
//  TwelveViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class TwelveViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var canvas: Canvas!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let array = [[3,3,3,3,3,3,3,3,3],
                     [2,3,3,3,3,3,3,3,1],
                     [1,3,3,3,3,3,3,3,2],
                     [3,3,3,3,3,3,3,3,3]]
        
        canvas.customStartSetting(from: array)
        
        settingLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let array = [[3,3,3,3,3,3,3,3,3],
                     [2,3,3,3,3,3,3,3,1],
                     [1,3,3,3,3,3,3,3,2],
                     [3,3,3,3,3,3,3,3,3]]
        
        canvas.customStartSetting(from: array)
        
    }
    
    func settingLabel() {
        
        let str = label.text!
        
        let mStr = NSMutableAttributedString(string: str)
        
        let font = UIFont.boldSystemFont(ofSize: 23)
        
        mStr.addAttributes([NSFontAttributeName: font], range: NSRange(location: 0, length: 30))
        
        
        let color1 = UIColor(red: 225/255.0, green: 78/255.0, blue: 70/255.0, alpha: 1)
        let color2 = UIColor(red: 234/255.0, green: 175/255.0, blue: 83/255.0, alpha: 1)
        let color3 = UIColor(red: 185/255.0, green: 217/255.0, blue: 70/255.0, alpha: 1)
        let color4 = UIColor(red: 140/255.0, green: 242/255.0, blue: 93/255.0, alpha: 1)
        let color5 = UIColor(red: 124/255.0, green: 242/255.0, blue: 146/255.0, alpha: 1)
        let color6 = UIColor(red: 128/255.0, green: 242/255.0, blue: 243/255.0, alpha: 1)
        let color7 = UIColor(red: 80/255.0, green: 133/255.0, blue: 238/255.0, alpha: 1)
        let color8 = UIColor(red: 93/255.0, green: 63/255.0, blue: 236/255.0, alpha: 1)
        let color9 = UIColor(red: 192/255.0, green: 72/255.0, blue: 237/255.0, alpha: 1)
        let color10 = UIColor(red: 226/255.0, green: 78/255.0, blue: 169/255.0, alpha: 1)

        
        
        mStr.addAttributes([NSForegroundColorAttributeName: color1], range: NSRange(location: 25, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color2], range: NSRange(location: 27, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color3], range: NSRange(location: 29, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color4], range: NSRange(location: 31, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color5], range: NSRange(location: 33, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color6], range: NSRange(location: 35, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color7], range: NSRange(location: 37, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color8], range: NSRange(location: 39, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color9], range: NSRange(location: 41, length: 1))
        mStr.addAttributes([NSForegroundColorAttributeName: color10], range: NSRange(location: 43, length: 1))

        
        self.label.text = nil
        self.label.attributedText = mStr

    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resetAction(_ sender: UIButton) {
        
        let array = [[3,3,3,3,3,3,3,3,3],
                     [2,3,3,3,3,3,3,3,1],
                     [1,3,3,3,3,3,3,3,2],
                     [3,3,3,3,3,3,3,3,3]]
        
        canvas.customStartSetting(from: array)
    }
    
}
