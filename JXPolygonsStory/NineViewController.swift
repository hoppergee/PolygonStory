//
//  NineViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class NineViewController: UIViewController {
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var trendChart: TrendChart!
    @IBOutlet weak var slider: UISlider!
    
    var timer: Timer?
    
    var array = [[Int]]()
    
    var alreadyStart = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        array = [
            [2,1,1,1,1,1,2,2,1,1,3,2,2,2,3,1,1,1,2,2],
            [2,2,1,1,1,2,2,1,1,1,1,3,2,2,1,1,1,1,2,3],
            [2,2,2,1,1,2,1,1,3,3,1,2,2,2,3,1,1,1,2,2],
            [2,2,2,2,2,2,3,1,1,3,1,2,2,2,1,3,1,1,2,2],
            [2,2,2,3,2,1,1,1,1,1,1,2,3,2,1,1,2,3,2,2],
            [2,3,3,2,2,1,1,1,1,1,3,3,2,2,3,1,2,2,2,2],
            [1,1,2,2,2,2,1,1,1,1,3,2,2,2,1,1,2,2,2,2],
            [1,3,2,2,2,1,3,3,1,1,1,2,2,3,2,3,2,2,2,2],
            [1,1,1,1,1,1,1,3,1,3,1,1,2,2,2,2,2,2,1,2],
            [3,1,1,2,2,1,3,1,3,2,3,3,2,2,3,2,2,1,1,1],
            [3,2,3,2,2,2,3,2,2,2,2,2,3,3,2,1,1,1,1,1],
            [2,2,2,2,2,3,2,2,2,1,1,2,2,2,2,1,1,3,1,1],
            [3,2,2,2,3,2,2,1,1,1,1,1,3,2,2,1,1,1,1,3],
            [2,1,3,1,2,2,2,3,3,2,1,1,2,2,2,2,1,1,1,3],
            [3,1,1,1,1,1,1,3,2,2,2,2,2,2,2,2,1,1,2,2],
            [1,1,1,1,1,1,1,3,1,2,3,2,2,2,3,2,3,2,2,2],
            [3,1,1,1,1,1,1,1,1,1,2,1,3,2,2,2,2,3,2,2],
            [3,1,1,3,1,1,1,3,1,3,1,1,1,1,1,1,3,1,2,2],
            [3,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1,2,2,1,1,1,1,1,2,1,1,1,1,1],
        ]
        
        canvas.customStartSetting(from: array)
        
        sliderSetting()
        
        setAttributeLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        canvas.customStartSetting(from: array)
        
        timer?.invalidate()
        canvas.customReset(from: self.array)
        trendChart.reset()
        alreadyStart = false
        sliderSetting()
        setAttributeLabel()
        
    }
    
    func sliderSetting() {
    slider.setMinimumTrackImage(UIImage(named:"trackMinGray")?.withRenderingMode(.alwaysOriginal), for: .normal)
        slider.thumbTintColor = UIColor.gray
        slider.addTarget(self, action: #selector(self.sliderAction(slider:)), for: .valueChanged)
        slider.value = 0.36
        canvas.setBias(36)
    }
    
    func sliderAction(slider: UISlider) {
        let number = String(format: "%.0f", slider.value*100)
        
        setAttributeLabel()
        
        let biasNumber = Int(number)!
        canvas.setBias(biasNumber)
    }
    
    func setAttributeLabel() {
        
        let number = String(format: "%.0f", slider.value*100)
        
        let str = "如果\(number)%以上的邻居跟我不同我就移出去"
        let mstr = NSMutableAttributedString(string: str)
        
        mstr.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSRange(location:2, length: 3))
        
        self.label.attributedText = mstr
    }
    
    @IBAction func startMove(_ sender: UIButton) {
        
        if alreadyStart == false {
            alreadyStart = true
            self.timer = Timer.scheduledTimer(timeInterval: 0.003, target: self, selector: #selector(self.autoPlay(timer:)), userInfo: nil, repeats: true)
        }
    }
    
    func autoPlay(timer: Timer) {
        canvas.autoPlay(timer: timer)
        drawLine()
    }
    
    func drawLine() {
        trendChart.segregations.append(canvas.dataSource.segregation)
        trendChart.setNeedsDisplay()
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        timer?.invalidate()
        canvas.customReset(from: self.array)
        trendChart.reset()
        alreadyStart = false
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
