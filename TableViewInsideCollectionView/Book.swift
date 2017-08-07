//
//  Book.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/6/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation

struct Book {
    private var _title : String? // 1 2
    private var _subtitle : String? // 1 2
    private var _publishedDate : String? // 1 2
    private var _olid : String? // 1
    private var _ebookFieldAvailable : Bool = false // 1 2
    private var _ebookAvailabilityStatus : String? // 1 2
    private var _isbn_10 : String? // .5
    private var _previewURL : String? // 1 2
    private var _coverURL : String? // 1 2
    private var _bookURL : String? // 1 2
    private var _publisher : String?
    var isValiedBook = true
    
    var title : String {
        if let temp1 = _title {
            if let temp2 = _subtitle {
                return "\(temp1) \(temp2)"
            }
            return "\(temp1)"
        }
        if let temp2 = _subtitle {
            return "\(temp2)"
        }
        return "Not Available"
    }
    
    var publishedDate : String {
        if let temp = _publishedDate {
            return temp
        }
        return "NA"
    }
    
    var previewUrl : String {
        if let temp = _previewURL{
            return temp
        }
        return "NA"
    }
    
    var bookUrl : String {
        if let temp = _bookURL {
            return temp
        }
        return "NA"
    }
    
    var coverImageUrl : String {
        if let temp = _coverURL {
            return temp
        }
        return "NA"
    }
    
    var ebookAvailabilty : String {
        if let temp = _ebookAvailabilityStatus {
            return temp
        }
        return "NA"
    }
    
    var ebookFieldAvailable : Bool {
        return _ebookFieldAvailable
    }
    
    var publisher : String {
        if let temp = _publisher {
            return temp
        }
        return "NA"
    }
    
    init(jsonArray json : [String : Any]){
        if let records = json["records"] as? [String : Any] {
            guard let firstkey = records.keys.first else {
                print("Book | init | Failed to parse first key of JSON[\"record\"]")
                return
            }
            if let book = records[firstkey] as? [String : Any]{
                if let data = book["data"] as? [String : Any]{
                    if let cover = data["cover"] as? [String : Any] {
                        if let temp = cover["medium"] as? String{
                            _coverURL = temp
                        } else {
                            print("Book | init | Warning : Cover Not available")
                        }
                    }
                    
                    _title = data["title"] as? String
                    _subtitle = data["subtitle"] as? String
                    _publishedDate = data["publish_date"] as? String
                    
                    if let ebooks = data["ebooks"] as? [Any] {
                        _ebookFieldAvailable = true
                        if let ebookEntry = ebooks[0] as? [String : Any]{
                            _ebookAvailabilityStatus = ebookEntry["availability"] as? String
                            _bookURL = ebookEntry["read_url"] as? String
                            _previewURL = ebookEntry["preview_url"] as? String
                        }
                    }
                    
                    if let temp = data["isbn"] as? [String]{
                        _isbn_10 = temp[0]
                    }
                    
                    if let publishers = data["publishers"] as? [[String : Any]]{
                        let temp = publishers[0]
                        if let name = temp["name"] as? String {
                            _publisher = name
                        }
                    }
                    
                }
                
                if let olids = book["OL6927784M"] as? [String] {
                    _olid = olids[0]
                }
                
                
            }
        } else {
            isValiedBook = false
        }
    }
}
