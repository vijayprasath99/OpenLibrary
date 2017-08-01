//
//  BookTVCell.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/1/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class BookTVCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var editionEbookLabel: UILabel!
    @IBOutlet weak var firstPublishedLabel: UILabel!
    
    func configureCell(with workObject : Work){
        self.backgroundView?.backgroundColor = UIColor.blue
        bookImageView.image = #imageLiteral(resourceName: "image-not-available")
        bookTitleLabel.text = workObject.title //book Title
        authorNameLabel.text = authorName(from: workObject.authors) //author Name
        editionEbookLabel.text = "\(workObject.numberOfEditions) editions (\(workObject.numberOfEbooks) ebook)"
        firstPublishedLabel.text = "first published in \(workObject.firstPublishedYear)"
    }
    
    private func authorName(from array : [String]) -> String {
        var authorNameTemp : String
        if array.count < 1{
            authorNameTemp = "Unknown"
        } else if array.count == 1 {
            authorNameTemp = array[0]
        } else {
            authorNameTemp = array[0]
            for name in array[1..<array.count]{
                authorNameTemp.append(", \(name)")
            }
            authorNameLabel.text = authorNameTemp
        }
        return authorNameTemp
    }

}
