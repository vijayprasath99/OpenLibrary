//
//  WVCBookCell.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/6/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class WVCBookCell: UITableViewCell {
    
    weak var buttonDeligate : ControlTransferDeligate?
    var bookObject : Book!
    
    @IBOutlet weak var editionImageView: UIImageView!
    @IBOutlet weak var publisherDateLbl: UILabel!
    @IBOutlet weak var availabilityLbl: UILabel!
    
    @IBOutlet weak var previewButtonOutlet: UIButton!
    @IBOutlet weak var readButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withBook book: Book, deligateForPassingControl controlTransferDeligate : ControlTransferDeligate){
        bookObject = book
        buttonDeligate = controlTransferDeligate
        let publisherName : String = book.publisher != "NA" ? book.publisher : "Unknown Publisher"
        let publishDate : String = book.publishedDate != "NA" ? book.publishedDate : "Publish date not available"
        let availabiltiy : String = book.ebookAvailabilty != "NA" ? book.ebookAvailabilty : "Not Available"
        publisherDateLbl.text = "\(publisherName) - \(publishDate)"
        availabilityLbl.text = availabiltiy.capitalized
        
        Network.sharedInstance.getImageFromWeb(book.coverImageUrl) { (downloadedImage) in
            if let image = downloadedImage {
                DispatchQueue.main.async {
                    self.editionImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.editionImageView.image = #imageLiteral(resourceName: "image-not-available")
                }
            }
        }
        
        // Buttons 
        if bookObject.previewUrl == "NA" {
            previewButtonOutlet.isEnabled = false
        }
        
        if bookObject.bookUrl == "NA" {
            readButtonOutlet.isEnabled = false
        }
        
    }
    
    @IBAction func previewButton(_ sender: UIButton) {
        buttonDeligate?.bringUpBrowser(forUrl: bookObject.previewUrl)
    }
    
    @IBAction func readButtonPressed(_ sender: UIButton) {
        buttonDeligate?.bringUpBrowser(forUrl: bookObject.previewUrl)
    }

}
