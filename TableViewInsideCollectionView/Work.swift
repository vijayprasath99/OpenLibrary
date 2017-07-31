//
//  Works.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 7/31/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation

class Work {
    private var _coverID : String?
    private var _title : String?
    private var _subtitle : String?
    private var _authors : [String]?
    private var _numberOfEditions : Int?
    private var _numberOfEbooks : Int?
    private var _firstPublishedYear : Int?
    private var _hasFullText : Bool?
    
    var title : String {
        if let temp = _title {
            return temp
        }
        return ""
    }
    
    var subtitle : String {
        if let temp = _subtitle {
            return temp
        }
        return ""
    }
    
    var authors : [String] {
        if let temp = _authors {
            return temp
        }
        return ["Unknown"]
    }
    
    var hasFullText : Bool {
        if let temp = _hasFullText {
            return temp
        }
        return false
    }
    
    var firstPublishedYear : Int {
        if let temp = _firstPublishedYear {
            return temp
        }
        return Int(Int64.max)
    }
    
    var coverIdSmall : String{
        if let temp = _coverID {
            return "olid/\(temp)-S.jpg"
        }
        return "olid/error"
    }
    
    var coverIdMedium : String{
        if let temp = _coverID {
            return "olid/\(temp)-M.jpg"
        }
        return "olid/error"
    }
    
    var coverIdLarge : String{
        if let temp = _coverID {
            return "olid/\(temp)-L.jpg"
        }
        return "olid/error"
    }
    
    var numberOfEbooks : Int {
        if let temp = _numberOfEbooks {
            return temp
        }
        return 0
    }
    
    init(jsonArray doc: [String : Any]){
        self._title = doc["title_suggest"] as? String
        self._subtitle = doc["subtitle"] as? String
        self._authors = doc["author_name"] as? [String]
        self._hasFullText = doc["has_fulltext"] as? Bool
        self._firstPublishedYear = doc["first_publish_year"] as? Int
        self._coverID = doc["printdisabled_s"] as? String // Need further Expansion
    }
}

extension Work{
    func printWork(){
        print("\(self.title) - \(self.subtitle) - \(self.authors) - \(self.hasFullText) -\(self.firstPublishedYear) - \(self.coverIdSmall)")
    }
}
