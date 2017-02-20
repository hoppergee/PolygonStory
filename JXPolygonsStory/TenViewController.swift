//
//  TenViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class TenViewController: UIViewController {
    @IBOutlet weak var canvas: Canvas!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    func reset() {
        let array = [[1,1,3,2,2],[1,1,3,2,2],[1,1,3,2,2],[1,1,3,2,2]]
        
        canvas.twoBiasStartSetting(from: array)
        canvas.setBias(0)
        canvas.setBias2(90)
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reset()
        
    }
    @IBAction func resetAction(_ sender: Any) {
        
        reset()
    }
}
