//
//  HomeCollectionViewCell.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAuthor: UILabel!
    @IBOutlet var ratingView: CosmosView!
    
    func populateData(book:Book){
        lblName.text = book.title
        lblDesc.text = book.desc
        lblAuthor.text = book.authors
        ratingView.rating = book.rating
        ratingView.settings.fillMode = .precise
        imgView.sd_setImage(with: URL.init(string: book.imgUrl), completed: nil)
        imgView.sd_setImage(with:  URL.init(string: book.imgUrl), placeholderImage: UIImage.init(named: "Placeholder"), options: .highPriority, completed: nil)
    }
}
