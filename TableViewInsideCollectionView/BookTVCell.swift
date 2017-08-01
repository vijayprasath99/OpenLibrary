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
        //Parameters
        bookTitleLabel.text = workObject.title //book Title
        authorNameLabel.text = "by \(authorName(from: workObject.authors))" //author Name
        editionEbookLabel.text = "\(workObject.numberOfEditions) editions (\(workObject.numberOfEbooks) ebook)"
        firstPublishedLabel.text = "first published in \(workObject.firstPublishedYear)"
        //Image
        getImageFromWeb(ImageSearchURL.urlWithOutDefaultImage(forID: workObject.coverIdMedium).formattedURL) { (downloadedImage) in
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
    
    private func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            print("File : BookTVCell.swift | Func : getImageFromWeb | Err : Something wrong URL Conversion :  ")
            return closure(nil)
        }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("File : BookTVCell.swift | Func : getImageFromWeb | Err : \(String(describing: error))")
                return closure(nil)
            }
            guard response != nil else {
                print("File : BookTVCell.swift | Func : getImageFromWeb | Err : no response")
                return closure(nil)
            }
            guard data != nil else {
                print("File : BookTVCell.swift | Func : getImageFromWeb | Err : no data")
                return closure(nil)
            }
            DispatchQueue.main.async {
                closure(UIImage(data: data!))
            }
        }; task.resume()
    }

}
