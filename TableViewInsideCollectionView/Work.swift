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
    private var _title_suggest : String?
    private var _subtitle : String?
    private var _title : String?
    private var _authors : [String]?
    private var _numberOfEditions : Int?
    private var _numberOfEbooks : Int?
    private var _firstPublishedYear : Int?
    private var _hasFullText : Bool?
    private var _lendingEdition : String?
    
    var title_suggest : String {
        if let temp = _title_suggest {
            return temp
        }
        return ""
    }
    
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
            return "olid/\(temp)-S"
        }
        return "olid/error"
    }
    
    var coverIdMedium : String{
        if let temp = _coverID {
            return "olid/\(temp)-M"
        }
        return "olid/error"
    }
    
    var coverIdLarge : String{
        if let temp = _coverID {
            return "olid/\(temp)-L"
        }
        return "olid/error"
    }
    
    var numberOfEbooks : Int {
        if let temp = _numberOfEbooks {
            return temp
        }
        return 0
    }
    
    var numberOfEditions : Int {
        if let temp = _numberOfEditions {
            return temp
        }
        return 0
    }
    
    var lendingEdition_Medium : String{
        if let temp = _lendingEdition {
            return "olid/\(temp)-M"
        }
        return "olid/error"
    }
    
    init(jsonArray doc: [String : Any]){
        self._title = doc["title"] as? String
        self._title_suggest = doc["title_suggest"] as? String
        self._subtitle = doc["subtitle"] as? String
        self._authors = doc["author_name"] as? [String]
        self._hasFullText = doc["has_fulltext"] as? Bool
        self._firstPublishedYear = doc["first_publish_year"] as? Int
        self._coverID = doc["printdisabled_s"] as? String // Need further Expansion
        self._numberOfEbooks = doc["ebook_count_i"] as? Int
        self._numberOfEditions = doc["edition_count"] as? Int
        self._lendingEdition = doc["lending_edition"] as? String
    }
}

extension Work{
    func printWork(){
        print("\(self.title_suggest) - \(self.subtitle) - \(self.authors) - \(self.hasFullText) -\(self.firstPublishedYear) - \(self.coverIdSmall)")
    }
}
