//
//  Polygon.swift
//  JXPolygonsStory
//
//  Created by 吉翔 on 10/22/16.
//  Copyright © 2016 吉翔. All rights reserved.
//

import Foundation

enum PolygonState: String {
    case Meh = "meh"
    case Sad = "sad"
    case Yay = "yay"
}

enum PolygonIdentity: String {
    case Square = "square"
    case Triangle = "triangle"
}

class Polygon {
    var state: PolygonState?
    var identity: PolygonIdentity?
    var indexPath: IndexPath?
    var isEmpty: Bool
    var sameness: Double?
    var isMoving = false
    
    init(state: PolygonState,identity: PolygonIdentity, indexPath: IndexPath){
        self.state = state
        self.identity = identity
        self.isEmpty = false
        self.indexPath = indexPath
        
    }
    
    init(indexPath: IndexPath) {
        isEmpty = true
        self.indexPath = indexPath
    }
    
    init() {
        isEmpty = true
    }
    
    
    static func square(with indexPath: IndexPath) -> Polygon{
        return Polygon(state: .Yay,identity: .Square, indexPath: indexPath)
    }
    
    static func Triangle(with indexPath: IndexPath) -> Polygon{
        return Polygon(state: .Yay,identity: .Triangle, indexPath: indexPath)
    }
}

extension Polygon: Equatable {
    
}

func ==(lf:Polygon,rf:Polygon) -> Bool{
    return lf.state == rf.state && lf.identity == rf.identity && lf.indexPath == rf.indexPath
}

class Empty: PCellData {
    
}
