//
//  FourViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {

    @IBOutlet weak var canvas: Canvas!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reset()
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        
        reset()
    }
    
    func reset() {
        let array = [[2,2,2,2,2,2,1,1,1,1,1,1],[2,2,3,1,2,2,1,1,2,3,1,1],[2,2,2,2,2,2,1,1,1,1,1,1]]
        
        canvas.customStartSetting(from: array)
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
