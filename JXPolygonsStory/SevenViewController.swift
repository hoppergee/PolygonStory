//
//  SevenViewController.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 31/10/2016.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class SevenViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var trendChart: TrendChart!
    
    var alreadyStart = false
    
    var time: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.startSetting(row: 20, col: 20)
        
        slider.setMinimumTrackImage(UIImage(named:"trackMinGray")?.withRenderingMode(.alwaysOriginal), for: .normal)
        slider.thumbTintColor = UIColor.gray
        slider.addTarget(self, action: #selector(self.sliderAction(slider:)), for: .valueChanged)
        
        setAttributeLabel(str: "33")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
    }
    
    func reset() {
        time?.invalidate()
        canvas.reset(row: 20, col: 20)
        trendChart.reset()
        alreadyStart = false
    }
    
    func sliderAction(slider: UISlider) {
        let number = String(format: "%.0f", slider.value*100)
        
        setAttributeLabel(str: number)
        
        let biasNumber = Int(number)!
        canvas.setBias(biasNumber)
        
    }
    
    func setAttributeLabel(str number: String) {
        let str = "如果\(number)%以上的邻居跟我不同我就移出去"
        let mstr = NSMutableAttributedString(string: str)
        
        mstr.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSRange(location: 2, length: 3))
        
        self.label.attributedText = mstr
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        
        if self.alreadyStart == false {
            alreadyStart = true
            self.time = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.autoPlay(timer:)), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        time?.invalidate()
        canvas.reset(row: 20, col: 20)
        trendChart.reset()
        alreadyStart = false
    }
    
    func autoPlay(timer: Timer) {
        canvas.autoPlay(timer:timer)
        drawLine()
    }
    
    func drawLine() {
        trendChart.segregations.append(canvas.dataSource.segregation)
        trendChart.setNeedsDisplay()
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
}
