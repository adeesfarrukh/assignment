//
//  BookDetailViewController.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
class BookDetailViewController: UIViewController {
    var book = Book.init(nil)
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAuthor: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var contentViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var btnPreview: UIButton!
    @IBOutlet var btnInfo: UIButton!
    @IBOutlet var btnCanonical: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        populateData(book: book)
        
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        ratingView.settings.fillMode = .precise
        let imageHeight =  CGFloat(200)
        let margins = CGFloat(50)
        let totalMarginBetweenLinks = CGFloat(30)
        let totalHeightOfLinks = CGFloat(90)
        contentViewHeightConstraint.constant = CGFloat(0).estimatedHeightOfLabel(text: book.desc, width: view.frame.width - 40) + margins + imageHeight + totalMarginBetweenLinks + totalHeightOfLinks
        btnInfo.setTitle(book.infoLink, for: .normal)
        btnPreview.setTitle(book.previewLink, for: .normal)
        btnCanonical.setTitle(book.canonicalVolumeLink, for: .normal)
        self.view.layoutIfNeeded()
    }
    
    
    func populateData(book:Book){
        lblName.text = book.title
        lblDate.text = book.publishedDate
        lblDesc.text = book.desc
        lblAuthor.text = book.authors
        ratingView.rating = book.rating
        imgView.sd_setImage(with:  URL.init(string: book.imgUrl), placeholderImage: UIImage.init(named: "Placeholder"), options: .highPriority, completed: nil)
    }
    
    @IBAction func didPressedLink(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: (sender.titleLabel?.text)!)! )
    }
        
        
        
}
