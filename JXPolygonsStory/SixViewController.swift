//
//  SixViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class SixViewController: UIViewController {

    @IBOutlet weak var canvas: Canvas!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        reset()
    }
    
    func reset() {
        let array = [[1,1,2,1,2,1,2,1,2,1,2,3],[1,2,1,2,1,2,1,2,1,2,1,2],[1,1,2,1,2,1,2,1,2,1,2,3]]
        canvas.customStartSetting(from: array)
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
