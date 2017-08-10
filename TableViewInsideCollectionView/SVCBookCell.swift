//
//  BookTVCell.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/1/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class SVCBookCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var editionEbookLabel: UILabel!
    @IBOutlet weak var firstPublishedLabel: UILabel!
    
    func configureCell(with workObject : Work){
        self.backgroundView?.backgroundColor = UIColor.blue
        //Parameters
        bookTitleLabel.text = workObject.title_suggest //book Title
        authorNameLabel.text = "by \(authorName(from: workObject.authors))" //author Name
        editionEbookLabel.text = "\(workObject.numberOfEditions) editions (\(workObject.numberOfEbooks) ebook)"
        firstPublishedLabel.text = "First Published in \(workObject.firstPublishedYear)"
        //Image
        Network.sharedInstance.getImageFromWeb(OpenAPI.imageUrlWithOutDefaultImage(forID: workObject.coverIdMedium).formattedURL) { (downloadedImage) in
            if downloadedImage == nil {
                self.bookImageView.image = #imageLiteral(resourceName: "image-not-available")
            } else {
                self.bookImageView.image = downloadedImage
            }
        }
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
