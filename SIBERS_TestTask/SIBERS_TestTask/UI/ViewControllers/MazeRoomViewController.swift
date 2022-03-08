//
//  MazeRoomViewController.swift
//  SIBERS_TestTask
//
//  Created by Anna Abdeeva on 07.03.2022.
//

import Foundation
import UIKit


class MazeRoomViewController: UIViewController, UIAlertViewDelegate {
    
    let mazeMap = MazeRoomGenerator.generateMap()
    var model: MazeRoomModel = MazeRoomModel(x: 0, y: 0)
    var previousSelected: IndexPath?
    var currentSelected: Int?
    
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
        
        configureView()
        configureArtifactButton()
    }
    
    @IBAction func didTapUpButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .up)
        configureArtifactButton()
        print("UP")
    }
    
    @IBAction func didTapDownButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .down)
        configureArtifactButton()
        print("DOWN")
    }
    
    @IBAction func didTapLeftButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .left)
        configureArtifactButton()
        print("LEFT")
    }
    
    @IBAction func didTapRightButton(_ sender: Any) {
        model.updateCoordinates(buttonTapped: .right)
        configureArtifactButton()
        print("RIGHT")
    }
    
    @IBAction func didTapArtifactButton(_ sender: Any) {
        model.updateArtifactStorage(buttonTapped: .artifact)
        print("Artifact")
    }
    
    @IBAction func didTapUseButton(_ sender: Any) {
        let artifacts = model.artifactStorage

        if let selectedItem = currentSelected {
            if artifacts[selectedItem].type == .usable {
//                model.stepsCounter += artifacts[selectedItem].bonusSteps
                model.updateSteps(artifacts[selectedItem].bonusSteps, selectedItem)
                updateRoomView()
            }
            else if artifacts[selectedItem].type == .key {
                let currentCoordinates = model.currentCoordinates
                if model.map[currentCoordinates.0][currentCoordinates.1] == .withTreasure {
                    let alert = UIAlertController(title: "Alert", message: "You won!", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Great", style: .default, handler: { action in
//                        switch action.style{
//                            case .default:
//                            print("default")
//
//                            case .cancel:
//                            print("cancel")
//
//                            case .destructive:
//                            print("destructive")
//
//                        }
//                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func didTapDropButton(_ sender: Any) {
    }
    
    @IBAction func didTapDiscardButton(_ sender: Any) {
    }
    
    @IBOutlet weak var stepsCountLabel: UILabel!
    
    
    
}

// MARK: - View configuration

private extension MazeRoomViewController {
    
    func configureView() {
        model.delegate = self
        configureArtifactStorageCollectionView()
        updateRoomView()
    }
    
    func configureArtifactStorageCollectionView() {
        artifactStorageCollectionView.delegate = self
        artifactStorageCollectionView.dataSource = self
        artifactStorageCollectionView.register(
            UINib(nibName: "ItemCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "cell"
        )
    }
    
    func configureArtifactButton() {
        let map = model.map
        let currentCoordinates = model.currentCoordinates
        
        if  map[currentCoordinates.0][currentCoordinates.1] == .empty {
            artifactButton.isHidden = true
        }
        if map[currentCoordinates.0][currentCoordinates.1] == .withKey {
            artifactButton.isHidden = false
            artifactButton.setImage(UIImage(named: "key.png"), for: .normal)
        }
        if map[currentCoordinates.0][currentCoordinates.1] == .withTreasure {
            artifactButton.isHidden = false
            artifactButton.setImage(UIImage(named: "treasure-chest.png"), for: .normal)
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
        else if currentCoordinates.0 - 1 >= 0 {
            if model.map[currentCoordinates.0 - 1][currentCoordinates.1] == .nonexistent {
                upButton.isHidden = true
            }
            else {
                upButton.isHidden = false
            }
        }
        
        //downButton check
        if currentCoordinates.0 == 3 {
            downButton.isHidden = true
        }
        else if currentCoordinates.0 + 1 <= 3 {
            if model.map[currentCoordinates.0 + 1][currentCoordinates.1] == .nonexistent {
                downButton.isHidden = true
            }
            else {
                downButton.isHidden = false
            }
        }
        
        //leftButton check
        if currentCoordinates.1 == 0 {
            leftButton.isHidden = true
        }
        else if currentCoordinates.1 - 1 >= 0 {
            if model.map[currentCoordinates.0][currentCoordinates.1 - 1] == .nonexistent {
                leftButton.isHidden = true
            }
            else {
                leftButton.isHidden = false
            }
        }
        
        //rightButton check
        if currentCoordinates.1 == 3 {
            rightButton.isHidden = true
        }
        else if currentCoordinates.1 + 1 <= 3 {
            if model.map[currentCoordinates.0][currentCoordinates.1 + 1] == .nonexistent {
                rightButton.isHidden = true
            }
            else {
                rightButton.isHidden = false
            }
        }
        
        stepsCountLabel.text = "Steps left: \(model.stepsCounter)"
    }
    
    func updateViewOfArtifactStorafe() {
        let buttonTapped: ButtonTapped = .artifact
        if buttonTapped == .artifact {
            artifactButton.isHidden = true
        }
        artifactStorageCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension MazeRoomViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.artifactStorage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ItemCollectionViewCell
        
        cell.configureCell(
            image: UIImage(named: model.artifactStorage[indexPath.row].image),
            info: model.artifactStorage[indexPath.row].info
        )
        
        if currentSelected != nil && currentSelected == indexPath.row {
            cell.backgroundColor = UIColor(red: 0.150, green: 0.420, blue: 0.150, alpha: 0.5)
        } else {
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // For remove previously selection
        if previousSelected != nil{
            if let cell = collectionView.cellForItem(at: previousSelected!){
                cell.backgroundColor = UIColor.clear
            }
        }
        currentSelected = indexPath.row
        previousSelected = indexPath
        
        artifactStorageCollectionView.reloadData()
    }
    
    
    
    //    func setBackgroundSelected(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ItemCollectionViewCell
    //
    //        // To set the selected cell background color here
    //        if currentSelected != nil && currentSelected == indexPath.row {
    //            cell.backgroundColor = UIColor.green
    //        }
    //        else {
    //            cell.backgroundColor = UIColor.yellow
    //        }
    //        return cell
    //    }
    //
    //    func removeBackgroundSelected(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        // For remove previously selection
    //        if previousSelected != nil{
    //            if let cell = collectionView.cellForItem(at: previousSelected!){
    //                cell.backgroundColor = UIColor.yellow
    //            }
    //        }
    //        currentSelected = indexPath.row
    //        previousSelected = indexPath
    //        artifactStorageCollectionView.reloadData()
    //    }
}


enum ButtonTapped {
    case left
    case right
    case up
    case down
    case artifact
}

struct Artifact {
    let image: String
    let info: String
    let type: ArtifactType
    let bonusSteps: Int
}

enum ArtifactType {
    case key
    case notUsable
    case usable
}
