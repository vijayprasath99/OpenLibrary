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
    
    func parseIntoWorksArray(data : Any) -> [Work] {
        var works = [Work]()
        let json = data as? [String : Any]
        if let docs = json?["docs"] as? [[String : Any]]{
            for doc in docs {
                let workCreated = Work(jsonArray: doc)
                workCreated.printWork()
                works.append(workCreated)
            }
        }
        return works
    }
    
    
    
}
