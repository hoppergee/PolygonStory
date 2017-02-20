//
//  Math.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 10/22/16.
//  Copyright © 2016 吉翔. All rights reserved.
//

import Foundation

class Math {
    
    static func randomInt(min: UInt32, max: UInt32) -> Int {
        return Int(arc4random_uniform(max - min + 1) + min)
    }
    
    static func randomPercent() -> Double {
        return Double(randomInt(min: 1, max: 100)) / 100.0
    }
    
    //从min到max之间取number个不相等的随机数
    static func randomInts(with number: Int, min: UInt32, max: UInt32) -> [Int]{
        var result = [Int]()
        var nums = [Int]()
        for i in min...max {
            nums.append(Int(i))
        }
        for _ in 1...number {
            let index = Int(arc4random_uniform(UInt32(nums.count)))
            let item = nums.remove(at: index)
            result.append(item)
        }
        return result
    }
    
}
