//
//  SearchVC.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 7/31/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.search
        
        networkTest()

    }
    
    func networkTest(){
        let jsonURL = "https://openlibrary.org/search.json?q=pokemon&has_fulltext=true"
        Network.sharedInstance.downloadJSON(from: jsonURL)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "[Undefined]")
    }


}
