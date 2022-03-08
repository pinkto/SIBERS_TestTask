//
//  MazeRoomModel.swift
//  SIBERS_TestTask
//
//  Created by Anna Abdeeva on 07.03.2022.
//

import Foundation

class MazeRoomModel {
    weak var delegate: ModelDelegate?
    var map = MazeRoomGenerator.generateMap()
    var x: Int
    var y: Int
    var currentCoordinates: (Int, Int) {
        return (x, y)
    }
    var stepsCounter: Int
    var artifactStorage: [Artifact] = [
        Artifact(image: "bone.png", info: "Nth", type: .notUsable, bonusSteps: 0),
        Artifact(image:"mushroom.png", info: "+5 Stp", type: .usable, bonusSteps: 5),
        Artifact(image: "stone.png", info: "Nth", type: .notUsable, bonusSteps: 0)
    ]
    
    //var buttonTapped: MazeRoomViewController = MazeRoomViewController()
    func updateCoordinates(buttonTapped: ButtonTapped) {
        stepsCounter -= 1
        if buttonTapped == .down {
            x += 1
            delegate?.updateRoomView()
        }
        if buttonTapped == .up {
            x -= 1
            delegate?.updateRoomView()
        }
        if buttonTapped == .left {
            y -= 1
            delegate?.updateRoomView()
        }
        if buttonTapped == .right{
            y += 1
            delegate?.updateRoomView()
        }
    }
    
    func updateArtifactStorage(buttonTapped: ButtonTapped) {
        if buttonTapped == .artifact {
            if map[currentCoordinates.0][currentCoordinates.1] == .withKey {
                artifactStorage.append(Artifact(image: "key.png", info: "Key", type: .key, bonusSteps: 0))
                map[currentCoordinates.0][currentCoordinates.1] = .empty
                delegate?.updateViewOfArtifactStorafe()
            }
        }
    }
    
    func updateSteps(_ steps: Int, _ id: Int) {
        stepsCounter += steps
        artifactStorage.remove(at: id)
        delegate?.updateViewOfArtifactStorafe()
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        self.stepsCounter = 20
    }
    
}
