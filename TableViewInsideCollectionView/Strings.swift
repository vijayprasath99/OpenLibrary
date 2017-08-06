//
//  Strings.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/1/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation

//#################################### Reuse Identifier ####################################

// Segue
let SEARCHVC_REUSE_IDENTIFIER : String = "BookViewCell"
let MAINVC_TABLEVIEW_CELL_REUSE_IDENTIFIER : String = "CatagoryCell"
let MAINVC_TABLEVIEW_CELL_COLLECTIONVIEW_CELL_REUSE_IDENTIFIER : String = "BookCell"

// Storyboard ID
let WORKDETAILSVC_STORYBOARDID = "WorkDetailsVC"

//#################################### URL ####################################

fileprivate let OPENAPI_PREFIX : String = "http://covers.openlibrary.org"
enum OpenAPI {
    case imageUrl(forID : String)
    case imageUrlWithOutDefaultImage(forID : String)
    case searchUrl(forSearch : String)
    
    var formattedURL : String {
        switch self{
        case let .imageUrl(forID):
            return "\(OPENAPI_PREFIX)/b/\(forID).jpg"
            
        case let .imageUrlWithOutDefaultImage(forID):
            return "\(OPENAPI_PREFIX)/b/\(forID).jpg?default=false"
            
        case let .searchUrl(forSearch):
            return "https://openlibrary.org/subjects/\(forSearch.lowercased()).json"
        }
    }
}
