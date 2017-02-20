//
//  TrendChart.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 10/25/16.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class TrendChart: UIView {
    
    var points = [CGPoint]()
    var segregations = [CGFloat]()
    var paths = [UIBezierPath]()
    
    var isReset = false
    
    var label = UILabel()
    
    var lineCount = 0
    
    var startIndex = 0
    
    override func draw(_ rect: CGRect) {
        
        if lineCount < 160 {
        
        for (index,seg) in segregations.enumerated() {
            
            if index >= startIndex {
                    
                    let index = index - startIndex
                
                    let pX:CGFloat = 10 + CGFloat(index) * 2 + 20
                    let height = self.bounds.height
                    let pY = (height - 20) * (1 - seg) * 2 - 25
                    let rect = CGRect(x: pX, y: pY, width: 2, height: 7)
                    let path = UIBezierPath(rect: rect)
                    paths.append(path)
                    UIColor.red.setFill()
                    path.fill()
                    
                    label.removeFromSuperview()
                    let labelRect = CGRect(x: (pX + 4), y: (pY - 20), width: 50, height: 40)
                    self.label = UILabel(frame: labelRect)
                    let str = String(format: "%.0f", seg*100)
                    label.text = "\(str)%"
                    label.textColor = UIColor.red
                    self.addSubview(label)
            }
            
        }
        }else {
            lineCount -= 60
            startIndex += 60
            
            label.removeFromSuperview()
            label = UILabel()
            
            paths = []
        }
        
        lineCount += 1
        
    }
    
    func reset() {
        label.removeFromSuperview()
        label = UILabel()
        
        paths = []
        points = []
        segregations = []
        
        lineCount = 0
        
        startIndex = 0
        
        self.setNeedsDisplay()
    }
    



}
