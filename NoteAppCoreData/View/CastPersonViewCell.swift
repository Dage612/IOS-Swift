//
//  CastPersonViewCell.swift
//  NoteAppCoreData
//
//  Created by Olman Mora on 28/6/21.
//

import UIKit

class CastPersonViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "CastPersonViewCell"
    
    public func configure(profileImage: String?, profileName: String ){
        if let image = profileImage {
            if let imageUrl = URL(string: image) {
                self.imageView.load(url: imageUrl)
            }
            
        }
        
        self.nameLabel.text = profileName
    }
}
