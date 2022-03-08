//
//  ModelDelegate.swift
//  SIBERS_TestTask
//
//  Created by Anna Abdeeva on 07.03.2022.
//

import Foundation

protocol ModelDelegate: AnyObject {
    func updateRoomView()
    func updateViewOfArtifactStorafe()
    func updateArtifactButton(_ imageName: String)
    func gameOver()
    func resetRoomView()
}
