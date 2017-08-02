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
        
        //Navigation Item
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationItem.title = "Search Books"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Activity Indicator
        self.activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.indicateLoading(false)
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Perform a search with API and reload table data
    fileprivate func performSearch(with searchKey: String){
        let formattedSearchKey : String = stringTransformedForSearch(from: searchKey)
        let jsonURL = "https://openlibrary.org/search.json?q=\(formattedSearchKey)&has_fulltext=true"
        Network.sharedInstance.downloadJSON2(from: jsonURL, completion: { (json) in
            self.worksArray = Parser.sharedInstance.worksArray(fromJsonData: json)
            DispatchQueue.main.async {
                self.indicateLoading(false)
                self.tableView.reloadData()

            }
        });
    }
    
    //Transform a Searchkey with spaces into proper format
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
    
    //Indicate to the user data is being loaded/processed
    fileprivate func indicateLoading(_ toggle : Bool){
        if toggle {
            tableView.alpha = 0.5
            activityIndicator.startAnimating()
        } else {
            tableView.alpha = 1
            activityIndicator.stopAnimating()
        }
        activityIndicator.isHidden = !toggle
        tableView.isUserInteractionEnabled = !toggle
    }
}

//Table View Functions
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let work = worksArray?[indexPath.row]{
            print(work.title, work.subtitle)
        }
    }
}

//Search Bar Functions
extension SearchVC : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        _searchBar(beingUsed: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _searchBar(beingUsed: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), text != "" {
            _searchBar(beingUsed: false)
            indicateLoading(true)
            performSearch(with: text)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.endUpdates()
        indicateLoading(false)
    }
    
    func _searchBar(beingUsed toggle : Bool){
        if toggle {
            searchBar.showsCancelButton = true
            tableView.alpha = 0.5
        } else {
            view.endEditing(true)
            indicateLoading(false)
            searchBar.showsCancelButton = false
            tableView.alpha = 1
        }
        tableView.isUserInteractionEnabled = !toggle
    }

}
