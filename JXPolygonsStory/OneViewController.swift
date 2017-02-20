//
//  OneViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    
    var array = [[Int]]()
    
    var isMove = false
    
    var legendPoint: CGPoint?
    
    @IBOutlet weak var canvas: Canvas!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        reset()
    }
    
    func reset() {
        array = [[1,1,1,3,3,3,3,3,3,2,1,2],
                 [1,1,1,3,3,3,3,3,3,1,2,1],
                 [1,1,2,3,3,3,3,3,3,3,1,2],
                 [1,1,1,3,3,3,3,3,3,1,2,1],
                 [1,1,1,3,3,3,3,3,3,2,1,2]]
        
        canvas.customStartSetting(from: array)
        canvas.canBlingBling = false
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        
        canvas.customReset(from: array)
        
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
}
