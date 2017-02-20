//
//  TwoViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    @IBOutlet weak var canvas1: Canvas!
    @IBOutlet weak var canvas2: Canvas!
    @IBOutlet weak var canvas3: Canvas!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reset()
    }
    
    func reset() {
        let array1 = [[1,3,1],[1,2,1],[1,3,2]]
        let array2 = [[1,3,1],[1,2,1],[2,3,2]]
        let array3 = [[2,3,2],[2,2,2],[2,3,2]]
        
        canvas1.customStartSetting(from: array1)
        canvas2.customStartSetting(from: array2)
        canvas3.customStartSetting(from: array3)
        
        canvas1.canBlingBling = false
        canvas2.canBlingBling = false
        canvas3.canBlingBling = false
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
