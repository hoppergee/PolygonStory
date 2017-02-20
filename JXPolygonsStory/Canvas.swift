//
//  Canvas.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 10/22/16.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

let CellTag = 100

class Canvas: UIView {
    
    var draggingCell: PCell?
    var dataSource: PolygonsDataSource!
    
    var diffPoint = CGPoint()
    var startPointCanNotMove = false
    
    var timer: Timer?
    
    var width: CGFloat!
    
    var correctPoint = CGPoint()
    
    var canBlingBling = true
    
    var allCell = [PCell]()
    
    var frameOfMoving = CGRect.zero
    

    //MARK: 初始化/重置布局
    //1.1根据行列随机初始化视图
    func startSetting(row: Int, col: Int) {
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(self.dragAction(sender:)))
        
        self.addGestureRecognizer(drag)
        
        self.width = (self.frame.width - (CGFloat(row) + 1) * 5) / CGFloat(row)
        
        let height = (self.width + 5) * CGFloat(col) + 5
        
        self.frameOfMoving = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
        
        self.dataSource = PolygonsDataSource(row: row, col: col)
        
        reset(row: row, col: col)
    }
    
    //1.2根据行列重置视图布局
    func reset(row: Int, col: Int){
        
        dataSource.savePointData(width: width, point: CGPoint.zero)
        dataSource.resetData()
        
        furtherReset(row: row, col: col)
    }
    
    //2.1以固定的样子初始化视图
    func customStartSetting(from array: [[Int]]) {
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(self.dragAction(sender:)))
        
        self.addGestureRecognizer(drag)
        
        let col = array.count
        let row = array[0].count
        
        self.width = (self.frame.width - (CGFloat(row) + 1) * 5) / CGFloat(row)
        
        let height = (self.width + 0.1 + 5) * CGFloat(col) + 5
        
        self.frameOfMoving = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
        
        self.dataSource = PolygonsDataSource(row: row, col: col)
        
        customReset(from: array)
    }
    
    //2.2根据传入数组重置视图布局
    func customReset(from array: [[Int]]) {
        
        let col = array.count
        let row = array[0].count
        
        self.correctPoint = correctPointCalculate(col: col, row: row, width: width)
        
        dataSource.savePointData(width: width, point: self.correctPoint)
        dataSource.resetData(from: array)
        
        furtherReset(row: row, col: col)
        
    }
    
    //3.以根据固定视图以两个偏见点初始化视图
    func twoBiasStartSetting(from array: [[Int]]) {
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(self.dragAction(sender:)))
        
        self.addGestureRecognizer(drag)
        
        let col = array.count
        let row = array[0].count
        
        self.width = (self.frame.width - (CGFloat(row) + 1) * 5) / CGFloat(row)
        
        let height = (self.width + 5) * CGFloat(col) + 5
        
        self.frameOfMoving = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
        
        self.dataSource = PolygonsDataSource(row: row, col: col)
        
        self.dataSource = PolygonsDataSource(row: row, col: col)
        
        self.dataSource.biasAdjustState = .Sad
        
        self.correctPoint = correctPointCalculate(col: col, row: row, width: width)
        
        dataSource.savePointData(width: width, point: self.correctPoint)
        dataSource.resetData(from: array)
        
        furtherReset(row: row, col: col)
    }
    

    
    //0.0 视图布局通用设置
    private func furtherReset(row: Int, col: Int) {
        
        for item in self.subviews {
            item.removeFromSuperview()
        }
        
        for section in 0..<col{
            for row in 0..<row{
                let indexPath = IndexPath(row: row, section: section)
                let item = dataSource.polygon(at: indexPath)
                if !(item.isEmpty) {
                    
                    let polygon = dataSource.newPolygon(judgeAt: indexPath)
                    let point = dataSource.point(at: indexPath).point
                    let size = CGSize(width: width, height: width)
                    let rect = CGRect(origin: point, size: size)
                    let cell = PCell(frame: rect)
                    
                    let identity = polygon.identity!
                    let state = polygon.state!
                    cell.setting(indexPath: indexPath,identity: identity, state: state)
                    
                    cell.tag = CellTag
                    allCell.append(cell)
                    self.addSubview(cell)
                    
                }
            }
        }
    }
}

//MARK: - 触摸事件
extension Canvas {
    
    //拖动触发事件
    func dragAction(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            
            touchStateStart(with: sender)
            
        case .changed:
            
            touchStateChange(with: sender)
            
        case .ended:
            
            touchStateEnd(with: sender)
            
        default:
            return
        }
    }
    
    //触摸详细实现
    
    func touchStateStart(with sender: UIPanGestureRecognizer){
        
        guard let cell = findACell(under: sender) else {
            startPointCanNotMove = true
            return
        }
        
        guard cell.isDragable() else {
            startPointCanNotMove = true
            return
        }
        
        diffPoint = createDiffPoint(between: cell, and: sender)
        cell.changePosition(by: diffPoint, with: sender)
        
        self.bringSubview(toFront: cell)
        
        draggingCell = cell
        startPointCanNotMove = false
    }
    
    func touchStateChange(with sender: UIPanGestureRecognizer){
        
        if startPointCanNotMove {
            return
        }
        
        draggingCell?.changePosition(by: diffPoint, with: sender)
        
    }
    
    func touchStateEnd(with sender: UIPanGestureRecognizer){
        if startPointCanNotMove {
            return
        }
        
        if isOutSide(sender: sender) {
            let start = draggingCell!.indexPath!
            
            draggingCell?.frame.origin = dataSource.point(at: start).point
        }
        else {
        
            let currentPoint = sender.location(in: self)
            let end = indexPath(of: currentPoint)
            let polygon = dataSource.polygon(at: end)
            
            if polygon.isEmpty{
                draggingCell?.frame.origin = dataSource.point(at: end).point
                
                let start = draggingCell!.indexPath!
                dataSource.swapData(between: start, and: end)
                let newPolygon = dataSource.polygon(at: end)
                
                draggingCell?.setting(indexPath: end, identity: newPolygon.identity!, state: newPolygon.state!)
                
                reloadCells(completionhander: { (end) in
                    
                })
                
                
                if !self.canBlingBling {
                    return
                }
                else if hasSomeoneStillSad() {
                    return
                }
                else {
                    endBlingBling()
                }
            }
            else{
                let start = draggingCell!.indexPath!
    
                draggingCell?.frame.origin = dataSource.point(at: start).point
            }
        }
        
    }
 
}

//MARK: - 自动移动 
extension Canvas {
    
    func autoPlay(timer: Timer) {

        if let polygon = dataSource.aRandomSadPolygon() {
            let cell = getCell(for: polygon.indexPath!)
            if let point = dataSource.aRandomEmptyPoint() {
                UIView.animate(withDuration: 0.5, animations: { 
                    cell.frame.origin = point.point
                }, completion: { (end) in
                    if end {
                        self.updateAllCell(around: cell, with: point, completionhander: { (end) in
                            if end {
                                self.dataSource.stopMoving(at: cell.indexPath)
                            }
                        })
                    }
                })
            }
        }
        else {
            if dataSource.hasAnySadPolygons() == false {
                timer.invalidate()
                self.endBlingBling()
            }
        }
    }
    
    //通过indexPath拿到相应的cell
    func getCell(for indexPath: IndexPath) -> PCell {
        var result = PCell()
        for cell in allCell {
            if cell.indexPath == indexPath {
                result = cell
            }
        }
        return result
    }

    
    //更新cell周边一圈的cell的状态
    func updateAllCell(around cell: PCell, with point: JXPoint, completionhander:(_ end:Bool)->Void){
        
        let start = cell.indexPath!
        let end = point.indexPath!
        
        dataSource.swapData(between: start, and: end)
            
        let newPolygon = dataSource.newPolygon(judgeAt: end)
        
        cell.setting(indexPath: end, identity: newPolygon.identity!, state: newPolygon.state!)
        
        reloadCells { (end) in
            if end {
                completionhander(true)
            }
        }
    }

    
    
    
}

//MARK: - 获取cell,刷新cell相关方法
extension Canvas {
    //计算触摸点与cell之间的相对坐标
    func createDiffPoint(between cell: PCell, and touch: UIPanGestureRecognizer) -> CGPoint{
        let currentPoint = touch.location(in: self)
        let diffX = cell.center.x - currentPoint.x
        let diffY = cell.center.y - currentPoint.y
        return CGPoint(x: diffX, y: diffY)
    }
    
    //刷新视图上需要刷新的cell
    func reloadCells(completionhander:(_ end: Bool)->Void){
        
        for cell in allCell {
            if !dataSource.isMoving(at: cell.indexPath) {
                if itNeed(refresh: cell) {
                    cell.setNeedsLayout()
                    completionhander(true)
                }
            }
        }
        
        completionhander(true)
    }
    
    //判断一个cell是否需要刷新
    func itNeed(refresh cell: PCell) -> Bool{
        let indexPath = cell.indexPath!
        let newPolygon = dataSource.newPolygon(judgeAt: indexPath)
        
        if cell.state != newPolygon.state{
            cell.state = newPolygon.state
            return true
        }
        else {
            return false
        }
    }
    
    //拿到触摸点下对应的cell
    func findACell(under touch: UIPanGestureRecognizer) -> PCell?{
        let point = touch.location(in: self)
        let currentIndexPath = indexPath(of: point)
        let currentCell = cell(for: currentIndexPath)
        return currentCell
    }
    
    //拿到indexPath对应的cell
    func cell(for indexPath: IndexPath) -> PCell?{
        var result: PCell?
        for item in self.subviews{
            if let cell = item as? PCell{
                if cell.indexPath == indexPath{
                    result = cell
                }
            }
        }
        return result
    }
    
    //计算出某点的indexPath
    func indexPath(of point: CGPoint) -> IndexPath {
        
        let section = Int((point.y - self.correctPoint.y - 5) / (width + 5))
        let row = Int((point.x - self.correctPoint.x - 5) / (width + 5))
        
        return IndexPath(row: row, section: section)
    }
    
    //判断是否超出边界
    func isOutSide(sender: UIPanGestureRecognizer) -> Bool {
        let point = sender.location(in: self)
        
        let xMin = self.frameOfMoving.origin.x
        let xMax = self.frameOfMoving.origin.x + self.frameOfMoving.width
        let yMin = self.frameOfMoving.origin.y
        let yMax = self.frameOfMoving.origin.y + self.frameOfMoving.height

        
        if point.y < yMin || point.y > yMax || point.x < xMin || point.x > xMax {
            return true
        }
        
        return false
    }
    
    //设置偏见下限
    func setBias(_ number: Int) {
        dataSource.bias = Double(number)/100
    }
    
    //设置个体偏见上限
    func setBias2(_ number: Int) {
        dataSource.bias2 = Double(number)/100
    }
    
    //cell坐标校正计算
    func correctPointCalculate(col: Int, row: Int, width: CGFloat) -> CGPoint {
        
        let x = (self.frame.width - (width + 5) * CGFloat(row) - 5) / 2.0
        let y = (self.frame.height - (width + 5) * CGFloat(col) - 5) / 2.0
        
        return CGPoint(x: x, y: y)
    }
    
    
    //检查视图上是否还有伤心的cell
    func hasSomeoneStillSad() -> Bool {
        
        for items in self.dataSource.polygons {
            for polygon in items {
                if !polygon.isEmpty && polygon.state == .Sad {
                    return true
                }
            }
        }
        
        return false
    }
    
    //成功后的闪烁动画
    func endBlingBling(){
        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.white
        view.alpha = 0
        self.addSubview(view)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.autoreverse], animations: {
            view.alpha = 1
        }, completion: { (end) in
            UIView.animate(withDuration: 0.2, animations: {
                view.alpha = 1
            }, completion: { (end) in
                UIView.animate(withDuration: 0.2, animations: {
                    view.alpha = 0
                }, completion: {(end) in
                    view.removeFromSuperview()
                })
            })
        })
    }
}


