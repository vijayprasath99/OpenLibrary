//
//  MVCCatagoryCell.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/2/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit

class MVCCatagoryCell: UITableViewCell {

    @IBOutlet weak var catagoryCollectionView: UICollectionView!
    @IBOutlet weak var catagoryTitleLabel: UILabel!
    
    var collectionViewOffset: CGFloat {
        get {
            return catagoryCollectionView.contentOffset.x
        }
        
        set {
            catagoryCollectionView.contentOffset.x = newValue
        }
    }

    
    func setCollectionViewDatasourceDelegate
        <D : UICollectionViewDelegate & UICollectionViewDataSource>
        (dataSourceDelegate: D, forRow row : Int){
        catagoryCollectionView.dataSource = dataSourceDelegate
        catagoryCollectionView.delegate = dataSourceDelegate
        catagoryCollectionView.tag = row
        catagoryCollectionView.reloadData()
    }
    
    func configureCel(title : String){
        catagoryTitleLabel.text = title.capitalized
    }
}
