//
//  MazeRoomModel.swift
//  SIBERS_TestTask
//
//  Created by Anna Abdeeva on 07.03.2022.
//

import Foundation

class MazeRoomModel {
    weak var delegate: ModelDelegate?
    let map = MazeRoomGenerator.generateMap()
    var x: Int
    var y: Int
    var currentCoordinates: (Int, Int) {
        return (x, y)
    }
    //var buttonTapped: MazeRoomViewController = MazeRoomViewController()
    func updateCoordinates(buttonTapped: ButtonTapped) {
        if buttonTapped == .down {
            x += 1
        }
        if buttonTapped == .up {
            x -= 1
        }
        if buttonTapped == .left {
            y -= 1
        }
        if buttonTapped == .left {
            y += 1
        }
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
}
