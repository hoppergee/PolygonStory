//
//  EightViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class EightViewController: UIViewController {

    @IBOutlet weak var canvas1: Canvas!
    @IBOutlet weak var canvas2: Canvas!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reset()
    }
    
    func reset() {
        let array1 = [[1,2,1],[2,3,2],[1,2,1]]
        let array2 = [[1,2,1],[2,3,2],[1,2,1]]
        
        canvas1.customStartSetting(from: array1)
        
        
        canvas2.customStartSetting(from: array2)
        canvas2.setBias(50)
    }

    @IBAction func resetCanvas1(_ sender: UIButton) {
        canvas1.customReset(from: [[1,2,1],[2,3,2],[1,2,1]])
    }
    @IBAction func resetCanvas2(_ sender: UIButton) {
        canvas2.customReset(from: [[1,2,1],[2,3,2],[1,2,1]])
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
