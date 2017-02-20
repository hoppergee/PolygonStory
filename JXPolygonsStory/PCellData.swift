//
//  PCellData.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 10/22/16.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class PCellData {
    
    var isEmpty = true
}

class JXPoint {
    var point: CGPoint
    var isOccupy = false
    var indexPath: IndexPath?
    
    init(_ point: CGPoint) {
        self.point = point
    }
    
    convenience init() {
        let point = CGPoint(x: 0, y: 0)
        self.init(point)
    }
}
