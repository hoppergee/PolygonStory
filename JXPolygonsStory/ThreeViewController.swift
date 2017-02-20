//
//  ThreeViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    @IBOutlet weak var canvas: Canvas!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.startSetting(row: 10, col: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        canvas.startSetting(row: 10, col: 10)
        
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        canvas.reset(row: 10, col: 10)
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
}
