//
//  MazeRoomViewController.swift
//  SIBERS_TestTask
//
//  Created by Anna Abdeeva on 07.03.2022.
//

import Foundation
import UIKit

 
class MazeRoomViewController: UIViewController {
    
    let mazeMap = MazeRoomGenerator.generateMap()
    var model: MazeRoomModel = MazeRoomModel(x: 0, y: 0)

    
    @IBOutlet weak var artifactStorageCollectionView: UICollectionView!
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var artifactButton: UIButton!
    
    @IBOutlet weak var useArtifactButton: UIButton!
    @IBOutlet weak var dropArtifactButton: UIButton!
    @IBOutlet weak var discardArtifactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this is a MazeRoomViewController")
        model.delegate = self
        configureView()
    }
    
    @IBAction func didTapUpButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .up)
        //delegate?.updateRoomView()
        print("UP")
    }
    
    @IBAction func didTapDownButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .down)
        //delegate?.updateRoomView()
        print("DOWN")
    }
    
    @IBAction func didTapLeftButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .left)
        //delegate?.updateRoomView()
        print("LEFT")
    }
    
    @IBAction func didTapRightButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .right)
        //delegate?.updateRoomView()
        print("RIGHT")
    }
    
}

// MARK: - View configuration

private extension MazeRoomViewController {
   
    func configureView() {
        
    }
    
    func configureArtifactButton(room: Int) {
        let map = model.map
        let currentCoordinates = model.currentCoordinates
        
        if  map[currentCoordinates.0][currentCoordinates.1] == .empty {
            artifactButton.isHidden = true
        }
    }
    

}

extension MazeRoomViewController: ModelDelegate {
    func updateRoomView() {
        let currentCoordinates = model.currentCoordinates
        // upButton check
        if currentCoordinates.0 == 0 {
            upButton.isHidden = true
        }
        else if currentCoordinates.1 - 1 >= 0 {
            if model.map[currentCoordinates.0][currentCoordinates.1 - 1] == .empty {
                upButton.isHidden = true
            }
        }
        else {
            upButton.isHidden = false
        }
        //downButton check
        if currentCoordinates.0 == 3 {
            downButton.isHidden = true
        }
        else if currentCoordinates.1 + 1 <= 3 {
            if model.map[currentCoordinates.0][currentCoordinates.1 + 1] == .empty {
                downButton.isHidden = true
            }
        }
        else {
            downButton.isHidden = false
        }
        //leftButton check
        if currentCoordinates.1 == 0 {
            leftButton.isHidden = true
        }
        else if currentCoordinates.0 - 1 >= 0 {
            if model.map[currentCoordinates.0 - 1][currentCoordinates.1] == .empty {
                leftButton.isHidden = true
            }
        }
        else {
            leftButton.isHidden = false
        }
        //rightButton check
        if currentCoordinates.1 == 3 {
            rightButton.isHidden = true
        }
        else if currentCoordinates.0 + 1 <= 3 {
            if model.map[currentCoordinates.0 + 1][currentCoordinates.1] == .empty {
                rightButton.isHidden = true
            }
        }
        else {
            rightButton.isHidden = false
        }
        
                
        
    }
}

enum ButtonTapped {
    case left
    case right
    case up
    case down
}


