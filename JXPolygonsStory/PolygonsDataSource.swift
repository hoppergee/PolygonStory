//
//  PolygonsDataSource.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 10/22/16.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class PolygonsDataSource {
    
    var polygons: [[Polygon]]
    private var pointsOfPolygons: [[JXPoint]]
    
    private var row: Int = 0
    private var col: Int = 0
    
    var bias = 0.33
    var bias2 = 0.99
    
    var biasAdjustState = PolygonState.Meh
    
    
    //MARK: ________开放接口________
    //MARK: -----初始化/重置方法-----
    //根据行列初始化阵列数据
    init(row: Int, col: Int){
        self.row = row
        self.col = col
        
        self.polygons = Array(repeating: Array(repeating: Polygon(), count: row), count: col)
        self.pointsOfPolygons = Array(repeating: Array(repeating: JXPoint(), count: row), count: col)
    }
    
    
    //在结合行列的重置以及初始化操作
    func resetData() {
        
        self.polygons = Array(repeating: Array(repeating: Polygon(), count: row), count: col)
        
        for section in 0..<col{
            for row in 0..<row{
                
                let indexPath = IndexPath(row: row, section: section)
                
                var polygon = Polygon(indexPath: indexPath)
                
                if Math.randomPercent() < 0.8 {
                    polygon = Math.randomPercent() <= 0.5 ? Polygon.square(with: indexPath) : Polygon.Triangle(with: indexPath)
                    
                    pointsOfPolygons[section][row].isOccupy = true
                }
                
                polygons[section][row] = polygon
            }
        }
    }
    
    //根据传入的二位数组初始化阵列数据
    func resetData(from array: [[Int]]) {
        
        self.polygons = Array(repeating: Array(repeating: Polygon(), count: row), count: col)
        
        for section in 0..<col{
            for row in 0..<row{
                let indexPath = IndexPath(row: row, section: section)
                let polygon = Polygon(indexPath: indexPath)
                if array[section][row] == 1 {
                    
                    polygons[section][row] = Polygon.square(with: indexPath)
                    pointsOfPolygons[section][row].isOccupy = true
                }
                else if array[section][row] == 2 {
                    
                    polygons[section][row] = Polygon.Triangle(with: indexPath)
                    pointsOfPolygons[section][row].isOccupy = true
                }
                else {
                    polygons[section][row] = polygon
                }
            }
        }
        
    }
    
    //初始化预设点阵列
    func savePointData(width: CGFloat, point correct: CGPoint){
        
        self.pointsOfPolygons = Array(repeating: Array(repeating: JXPoint(), count: row), count: col)
        
        let cX = correct.x
        let cY = correct.y
        
        for section in 0..<col{
            for row in 0..<row{
                let point = CGPoint(x: 5 + CGFloat(row)*(width+5) + cX, y: 5 + CGFloat(section)*(width+5) + cY)
                let jxPoint = JXPoint(point)
                jxPoint.indexPath = IndexPath(row: row, section: section)
                pointsOfPolygons[section][row] = jxPoint
            }
        }
        
    }
    
    //MARK: -------辅助方法--------
    //根据传入的index值查看周边状态,来判断自己的心情,并贡献分裂读基数
    func newPolygon(judgeAt indexPath: IndexPath) -> Polygon{
        
        let section = indexPath.section
        let row = indexPath.row
        
        let upSection = section - 1 >= 0 ? section - 1 : section
        let downSection = section + 1 < self.col ? section + 1 : section
        let leftRow = row - 1 >= 0 ? row - 1 : row
        let rightRow = row + 1 < self.row ? row + 1 : row
        
        var neighbors:Double = 0
        var same:Double = 0
        
        for section in upSection...downSection {
            for row in leftRow...rightRow {
                
                if IndexPath(row: row, section: section) != indexPath {
                    let polygon = polygons[section][row]
                    if !(polygon.isEmpty) {
                        neighbors += 1
                        let currentItem = polygons[indexPath.section][indexPath.row]
                        if polygon.identity == currentItem.identity {
                            same += 1
                        }
                    }
                }
            }
        }
        
        let polygon = polygons[section][row]
        var sameness:Double = 0
        if neighbors != 0 {
            sameness = same/neighbors
        }
        
        if sameness < self.bias {
            polygon.state = .Sad
        }
        else if sameness > self.bias2 {
            polygon.state = biasAdjustState
        }
        else {
            polygon.state = .Yay
        }
        polygon.sameness = sameness
        
        return polygon
    }
    
    func hasAnySadPolygons() -> Bool {
        if let _ = allSadPolygons() {
            return true
        }
        
        return false
    }
    
    func isMoving(at indexPath: IndexPath) -> Bool {
        let polyon = polygons[indexPath.section][indexPath.row]
        if polyon.isMoving {
            return true
        }
        return false
    }
    
    func point(at indexPath: IndexPath) -> JXPoint{
        return pointsOfPolygons[indexPath.section][indexPath.row]
    }
    
    func polygon(at indexPath: IndexPath) -> Polygon{
        return polygons[indexPath.section][indexPath.row]
    }

    
    //MARK: --------自动移动--------
    //1. 拿到随机伤心多边形
    func aRandomSadPolygon() -> Polygon? {
        
        if let allSad = allSadAndNotMovingPolygons() {
            
            let randomIndex = Math.randomInt(min: 0, max: UInt32(allSad.count - 1))
            let polygon = allSad[randomIndex]
            
            polygon.isMoving = true
            
            return polygon
        }
        
        return nil
    }
    
    //2.拿到一个随机的空点
    func aRandomEmptyPoint() -> JXPoint? {
        let points = pointsOfEmptyPolygons()
        
        if points.count == 0 {
            return nil
        }
        
        let randomIndex = Math.randomInt(min: 0, max: UInt32(points.count - 1))
        let point = points[randomIndex]
        point.isOccupy = true
        return point
    }
    
    

    
    //3. 多边形数据位置变化
    func swapData(between start: IndexPath, and end: IndexPath){
        
        let startItem = polygons[start.section][start.row]
        let endItem = polygons[end.section][end.row]
        let temp = startItem.indexPath
        startItem.indexPath = endItem.indexPath
        endItem.indexPath = temp
        
        swap(&polygons[start.section][start.row], &polygons[end.section][end.row])
        
        point(at: start).isOccupy = false
    }
    
    //4.1 多边形停止移动
    func stopMoving(at indexPath: IndexPath) {
        polygons[indexPath.section][indexPath.row].isMoving = false
    }
    
    private func allSadAndNotMovingPolygons() -> [Polygon]? {
        var result = [Polygon]()
        for section in 0..<self.col{
            for row in 0..<self.row{
                let polygon = polygons[section][row]
                if !polygon.isEmpty && polygon.state == .Sad && !polygon.isMoving {
                    let polygon = polygons[section][row]
                    result.append(polygon)
                }
            }
        }
        
        if result.count == 0 {
            return nil
        }
        
        return result
    }
    
    //MARK: -------趋势图数据---------
    //获取分裂度的接口
    var segregation: CGFloat {
        get{
            return self.getSegregation()
        }
    }
    
    
    //MARK: ________隐藏接口____________
    
    private func getSegregation() -> CGFloat {
        var sum = 0.0
        var count = 0.0
        for section in 0..<self.col{
            for row in 0..<self.row{
                let polygon = polygons[section][row]
                if !polygon.isEmpty {
                    sum += polygon.sameness!
                    count += 1
                }
            }
        }
        return CGFloat(sum / count)
    }
    
    private func allSadPolygons() -> [Polygon]?{
        var result = [Polygon]()
        for section in 0..<self.col{
            for row in 0..<self.row{
                let polygon = polygons[section][row]
                if !polygon.isEmpty && polygon.state == .Sad {
                    let polygon = polygons[section][row]
                        result.append(polygon)
                }
            }
        }
        
        if result.count == 0 {
            return nil
        }
        
        return result
    }
    

    
    //拿到所有没有被占用的空点
    private func pointsOfEmptyPolygons() -> [JXPoint]{
        var points = [JXPoint]()
        for section in 0..<self.col{
            for row in 0..<self.row{
                let polygon = polygons[section][row]
                if polygon.isEmpty {
                    let jxPoint = pointsOfPolygons[section][row]
                    if !jxPoint.isOccupy {
                        points.append(jxPoint)
                    }
                }
            }
        }
        return points
    }
    

    

}
