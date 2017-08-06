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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if workObject != nil {
            print(workObject.title_suggest,workObject.subtitle, workObject.title)
        }
    }
}
