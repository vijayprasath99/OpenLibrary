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
            }
        }
        return worksArray
    }

    
    func bookObject(fromJsonData data : Any) -> Book{
        if let json = data as? [String : Any] {
            let bookObject = Book(jsonArray: json)
            return bookObject
        }
        let dummy = "" as Any
        return Book(jsonArray: ["" : dummy])
    }
    
    func date(fromUnixTimeStamp date : String) -> String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.long //Set date style
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date as Date)  + " UTC"
        return localDate
    }
    
    func string<T>(fromArray array: [T]) -> String{
        var str : String = "Unknown"
        if array.count == 1 {
            str = "\(array[0])"
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
