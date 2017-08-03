//
//  MVCBookCell.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/2/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class MVCBookCell: UICollectionViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    func configureCell(with workObject : Work){
        bookTitleLabel.text = workObject.title + workObject.subtitle
        let url = OpenAPI.imageUrlWithOutDefaultImage(forID: workObject.lendingEdition_Medium).formattedURL
        Network.sharedInstance.getImageFromWeb(url) { (downloadedImage) in
            let image : UIImage?
            if downloadedImage == nil { image = #imageLiteral(resourceName: "image-not-available") }
            else { image = downloadedImage }
            DispatchQueue.main.async {
                guard let image = image else { print("MVCBookCell.swift | configureCell(with:) | Err : Problem in assigning image"); return }
                self.bookImageView.image = image
            }
        }
    }
}
