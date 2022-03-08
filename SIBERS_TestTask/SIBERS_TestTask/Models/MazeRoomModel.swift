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
    var artifactsOnMap: [ArtifactOnMap] = []
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        self.stepsCounter = 20
    }
    
    func updateCoordinates(buttonTapped: ButtonTapped) {
        stepsCounter -= 1
        
        if stepsCounter == 0 {
            delegate?.gameOver()
        }
        
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
    
    func discardArtifact(_ id: Int) {
        artifactStorage.remove(at: id)
        delegate?.updateViewOfArtifactStorafe()
    }
    
    func dropArtifact(_ id: Int) {
        map[currentCoordinates.0][currentCoordinates.1] = .withArtifact
        artifactsOnMap.append(ArtifactOnMap(
            artifact: artifactStorage[id], x: currentCoordinates.0, y: currentCoordinates.1
        ))
        delegate?.updateArtifactButton(artifactStorage[id].image)
        artifactStorage.remove(at: id)
    }
    
    func updateSteps(_ steps: Int, _ id: Int) {
        stepsCounter += steps
        artifactStorage.remove(at: id)
        delegate?.updateViewOfArtifactStorafe()
    }
    
    func getArtifact() -> Artifact? {
        let artifact = artifactsOnMap.first { $0.x == currentCoordinates.0 && $0.y == currentCoordinates.1 }
        return artifact?.artifact
    }
    
    func restartGame() {
        x = 0
        y = 0
        map = MazeRoomGenerator.generateMap()
        artifactsOnMap.removeAll()
        stepsCounter = 20
        delegate?.updateRoomView()
        delegate?.resetRoomView()
    }
}

struct ArtifactOnMap {
    let artifact: Artifact
    let x: Int
    let y: Int
}
