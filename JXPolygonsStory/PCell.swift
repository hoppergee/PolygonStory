//
//  PCell.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 10/22/16.
//  Copyright © 2016 吉翔. All rights reserved.
//

import UIKit

class PCell: UIView {
    
    var imageView: UIImageView?
    var beingDraged = false
        
    
    var state: PolygonState?{
        didSet{
            if state != .Sad {
                beingDraged = false
            }else{
                beingDraged = true
            }
        }
    }
    var identity: PolygonIdentity?
    var indexPath: IndexPath!
    
    func setting(indexPath: IndexPath,identity: PolygonIdentity, state: PolygonState){
        self.indexPath = indexPath
        self.identity = identity
        self.state = state
        showSelf()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView!)
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        showSelf()
    }
    
    func showSelf(){
        if state == .Sad{
            becomeSad()
        }
        else if state == .Meh{
            becomeMeh()
        }
        else if state == .Yay{
            becomeYay()
        }
    }
    
    func becomeSad(){
        imageView?.layer.removeAllAnimations()
        imageView?.transform = CGAffineTransform(rotationAngle: 0)
        imageView?.animationImages = nil
        let imageName = "\(state!.rawValue)_\(identity!.rawValue)"
        imageView?.image = UIImage(named: imageName)
        imageView?.layer.removeAllAnimations()
        imageView?.transform = CGAffineTransform(rotationAngle: -0.2)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.repeat,.autoreverse],
                       animations: {
                           self.imageView?.transform = CGAffineTransform(rotationAngle: 0.2)
                       }, completion: nil)
    }
    
    func becomeYay(){
        imageView?.layer.removeAllAnimations()
        imageView?.transform = CGAffineTransform(rotationAngle: 0)
        let imageName1 = "yay_\(identity!.rawValue)"
        let imageName2 = "yay_\(identity!.rawValue)_blink"
        let image1 = UIImage(named: imageName1)!
        let image2 = UIImage(named: imageName2)!
        
        imageView?.animationImages = [image1,image1,image1,image1,image1,image1,image1,image1,image1,image1,image2]
        imageView?.animationDuration = 2
        imageView?.startAnimating()
    }
    
    func becomeMeh(){
        imageView?.layer.removeAllAnimations()
        imageView?.transform = CGAffineTransform(rotationAngle: 0)
        imageView?.animationImages = nil
        let imageName = "\(state!.rawValue)_\(identity!.rawValue)"
        imageView?.image = UIImage(named: imageName)
    }
    
    func stopAnimation() {
        imageView?.layer.removeAllAnimations()
    }
    
    func isDragable() -> Bool{
        if state == .Sad {
            return true
        }
        else {
            return false
        }
    }
    
    
    func changePosition(by diff: CGPoint,with touch: UIPanGestureRecognizer){
        let currentPoint = touch.location(in: self.superview)
        let newX = currentPoint.x + diff.x
        let newY = currentPoint.y + diff.y
        self.center = CGPoint(x: newX, y: newY)
    }
    
    func updateCenter(by diff: CGPoint, with touch: UIPanGestureRecognizer, frame: CGRect) {
        let currentPoint = touch.location(in: self.superview)
        let newX = currentPoint.x + diff.x
        let newY = frame.origin.y - 1
        self.center = CGPoint(x: newX, y: newY)
    }
}
