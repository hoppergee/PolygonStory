//
//  FourteenViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 03/11/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class FourteenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func returnAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func restartAction(_ sender: UIButton) {
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }

}
