//
//  SearchVC.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 7/31/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    var worksArray : [Work]?

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Search Bar
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchBar.returnKeyType = UIReturnKeyType.search
        
        //Activity Indicator
//        activityIndicator.backgroundColor = UIColor.black
        self.activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.indicateLoading(false)
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func performSearch(with searchKey: String){
        let formattedSearchKey : String = stringTransformedForSearch(from: searchKey)
        let jsonURL = "https://openlibrary.org/search.json?q=\(formattedSearchKey)&has_fulltext=true"
        Network.sharedInstance.downloadJSON2(from: jsonURL, completion: { (json) in
            self.worksArray = Parser.sharedInstance.worksArray(fromJsonData: json)
            self.indicateLoading(false)
            self.tableView.reloadData()
        });
    }
    
    fileprivate func stringTransformedForSearch(from oldString: String) -> String {
        let newStringArray = oldString.components(separatedBy: " ")
        if newStringArray.count == 0 {
            return "Undefined"
        } else if newStringArray.count < 2 {
            return newStringArray[0]
        } else {
            var newString = newStringArray[0]
            for key in newStringArray[1..<newStringArray.count]{
                newString.append("+\(key)")
            }
            return newString
        }
    }
    
    fileprivate func indicateLoading(_ toggle : Bool){
        if toggle {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
}

extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = worksArray {
            return item.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let worksArray = worksArray else {
            print("Works Array not initialized!")
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SEARCHVC_REUSE_IDENTIFIER) as?  BookTVCell{
            cell.configureCell(with: worksArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SearchVC : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), text != "" {
            performSearch(with: text)
            view.endEditing(true)
            indicateLoading(true)
        }
    }

}
