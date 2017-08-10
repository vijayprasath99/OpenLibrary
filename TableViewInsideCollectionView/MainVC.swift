//
//  ViewController.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 7/30/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class MainVC: UIViewController{
    
    var refreshControl: UIRefreshControl!
    var subjects = FileManager.sharedInstance.loadSubjects()
    var model = [[Work]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Navigation Controller Color
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 126/255, blue: 163/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Menlo", size: 20)!,
                                                                   NSForegroundColorAttributeName: UIColor.white]
//        Bradley Hand | Menlo

    
        //Table View Parameters!
        tableView.dataSource = self
        tableView.delegate = self
        
        downloadModelData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // Refresh Controller
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    
    }
    
    func refresh(sender:AnyObject) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func downloadModelData(completionHandler : @escaping ()->()){
        
        for subject in subjects {
            let url = OpenAPI.searchUrl(forSearch: subject).formattedURL
            Network.sharedInstance.downloadJSON2(from: url, completion: { (downloadedData) in
                let workObject = Parser.sharedInstance.worksArray(fromJsonSubjectData: downloadedData)
                self.model.append(workObject)
                completionHandler()
            })
        }
    }
}

extension MainVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: MAINVC_TABLEVIEW_CELL_REUSE_IDENTIFIER) as? MVCCatagoryCell {
            tableViewCell.configureCel(title: subjects[indexPath.row])
            return tableViewCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MVCCatagoryCell else { return }
        
        tableViewCell.setCollectionViewDatasourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
}

extension MainVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAINVC_TABLEVIEW_CELL_COLLECTIONVIEW_CELL_REUSE_IDENTIFIER, for: indexPath) as? MVCBookCell {
            cell.configureCell(with: model[collectionView.tag][indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let work = model[collectionView.tag][indexPath.item]
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: WORKDETAILSVC_STORYBOARDID) as? WorkDetailsVC else {
            print("MainVC | didSelectItemAt | Err : Problem instantiating WorkDeatilsVC");
            return
        }
        
        vc.workObject = work
        navigationController?.pushViewController(vc, animated: true)
    }
}
