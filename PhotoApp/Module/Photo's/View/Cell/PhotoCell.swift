//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Yahia El-Dow on 15/05/2022.
//

import UIKit

class PhotoCell: UITableViewCell {
    @IBOutlet private weak var photoImageView: UIImageView! {
        didSet {
            self.photoImageView.setDefaultImage()
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = ""
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func  config(title: String, imgUrl: String) {
        self.photoImageView.setDefaultImage()
        self.photoImageView?.downloadImage(from: imgUrl)
        self.titleLabel.text = title
    }
    
}
