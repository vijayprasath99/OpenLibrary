//
//  Parser.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 7/31/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation

class Parser {
    static let sharedInstance = Parser()
    
    func worksArray(fromJsonData data : Any) -> [Work] {
        var works = [Work]()
        let json = data as? [String : Any]
        if let docs = json?["docs"] as? [[String : Any]]{
            for doc in docs {
                let workCreated = Work(jsonArray: doc)
                works.append(workCreated)
            }
        }
        return works
    }
    
    func worksArray(fromJsonSubjectData data: Any) -> [Work]{
        var worksArray = [Work]()
        let json = data as? [String : Any]
        if let works = json?["works"] as? [[String : Any]]{
            for work in works{
                let workObject = Work(jsonArray: work)
                worksArray.append(workObject)
//                print(workObject.title, workObject.lendingEdition_Medium)
            }
        }
        return worksArray
    }
    
}
