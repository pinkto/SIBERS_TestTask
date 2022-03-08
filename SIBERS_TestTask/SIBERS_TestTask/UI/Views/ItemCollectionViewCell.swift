//
//  ItemCollectionViewCell.swift
//  SIBERS_TestTask
//
//  Created by Anna Abdeeva on 08.03.2022.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet var itemInfoLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    
    func configureCell(image: UIImage?, info: String) {
        if let unwrappedImage = image {
            self.itemImageView.image = unwrappedImage
        }
        self.itemInfoLabel.text = info
    }
}
