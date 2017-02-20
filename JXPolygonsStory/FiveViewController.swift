//
//  FiveViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var trendChart: TrendChart!
    @IBOutlet weak var trendChart1: TrendChart!
    
    var alreadyStart = false
    
    var time: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.startSetting(row: 20, col: 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        canvas.startSetting(row: 20, col: 20)
        time?.invalidate()
        canvas.reset(row: 20, col: 20)
        trendChart.reset()
        alreadyStart = false
    }
    
    @IBAction func startMove(_ sender: UIButton) {
        if self.alreadyStart == false {
            alreadyStart = true
            self.time = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(self.autoPlay(timer:)), userInfo: nil, repeats: true)
        }

    }
    
    func autoPlay(timer: Timer) {
        canvas.autoPlay(timer:timer)
        drawLine()
    }
    
    func drawLine() {
        trendChart.segregations.append(canvas.dataSource.segregation)
        trendChart.setNeedsDisplay()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        time?.invalidate()
        canvas.reset(row: 20, col: 20)
        trendChart.reset()
        alreadyStart = false
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
