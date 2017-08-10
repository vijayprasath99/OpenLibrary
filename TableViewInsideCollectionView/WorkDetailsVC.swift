//
//  WorkDetailsVC.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/1/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class WorkDetailsVC: UIViewController {
    
    var workObject : Work!
    var imageIsSet : Bool = false
    var editionTableDataSource = [Book]()
    
    // IBOUTLET
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var firstPublishedLbl: UILabel!
    @IBOutlet weak var isbnLbl: UILabel!
    @IBOutlet weak var libraryAnythingLbl: UILabel!
    @IBOutlet weak var goodReadLbl: UILabel!
    @IBOutlet weak var languagesAvailableLbl: UILabel!
    @IBOutlet weak var lastModifiedLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureCell()
        
        // Tabel View Elements

    }
    
    func configureCell(){
        titleLbl.text = workObject.title_full
        authorLbl.text = string(fromArray: workObject.authors)
        firstPublishedLbl.text = "\(workObject.firstPublishedYear)"
        isbnLbl.text = "\(string(fromArray: workObject.isbn))"
        libraryAnythingLbl.text = "\(string(fromArray: workObject.libraryThingID))"
        goodReadLbl.text = "\(string(fromArray: workObject.goodReadID))"
        languagesAvailableLbl.text = "\(string(fromArray: workObject.languagesAvailable.flatMap({ $0.capitalized })))"
        lastModifiedLbl.text = workObject.lastModifiedInString
        
        // Set Image
        let imageURL = OpenAPI.imageUrlWithOutDefaultImage(forID: workObject.coverIdLarge).formattedURL
        downloadAndSetImage(fromURL: imageURL)
        if !imageIsSet {
            let imageURL2 = OpenAPI.imageUrlWithOutDefaultImage(forID: workObject.lendingEdition_Medium).formattedURL
            downloadAndSetImage(fromURL: imageURL2)
            if !imageIsSet {
                bookImageView.image = #imageLiteral(resourceName: "image-not-available")
            }
        }
        
        // Edition ID
        let editionKeyArray = workObject.editionFormattedKeyArrayForAPI
        if editionKeyArray.count < 1 {
            tableView.isHidden = true
        } else {
            for edition in workObject.editionFormattedKeyArrayForAPI{
                let bookUrl = OpenAPI.bookUrl(forID: edition).formattedURL
                Network.sharedInstance.downloadJSON2(from: bookUrl, completion: { (downloadedJSON) in
                    let book = Parser.sharedInstance.bookObject(fromJsonData: downloadedJSON)
                    if book.isValiedBook {
                        self.editionTableDataSource.append(book)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    private func downloadAndSetImage(fromURL imageURL: String){
        Network.sharedInstance.getImageFromWeb(imageURL) { (downloadedImage) in
            if let image = downloadedImage {
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                    self.imageIsSet = true
                }
            }
        }
    }
    
    private func string<T>(fromArray array: [T]) -> String{
        var str : String = ""
        if array.count == 1 {
            str = "\(array[0])"
            return str
        } else if array.count > 1 {
            str = "\(array[0])"
            for i in 1..<array.count {
                str = "\(str), \(array[i])"
            }
            return str
        }
        return str
    }
}

extension WorkDetailsVC : UITableViewDelegate{
    
}

extension WorkDetailsVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editionTableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WORKDETAILEDVC_TABLEVIEW_CELL_REUSE_IDENTIFIER) as? WVCBookCell {
            let temp = editionTableDataSource[indexPath.row]
            cell.configureCell(withBook: temp, deligateForPassingControl: self)
            return cell
        }
        return UITableViewCell()
        
    }
}

extension WorkDetailsVC : ControlTransferDeligate {
    func bringUpBrowser(forUrl url: String){
        if let vc = storyboard?.instantiateViewController(withIdentifier: BOOKBROWSERVC_STORYBOARDID) as? BookBrowserVC {
            vc.url = url
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
