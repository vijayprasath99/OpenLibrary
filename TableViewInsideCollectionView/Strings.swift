//
//  Strings.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/1/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation

let SEARCHVC_REUSE_IDENTIFIER : String = "BookViewCell"

fileprivate let IMAGESEARCH_PRE : String = "http://covers.openlibrary.org/b"
fileprivate let IMAGESEARCH_POST : String = ".jpg"
fileprivate let IMAGESEARCH_FALSE_DEFAULT_PARAMETER : String = "?default=false"

enum ImageSearchURL{
    case url(forID : String)
    case urlWithOutDefaultImage(forID : String)
    
    var formattedURL : String {
        switch self{
        case let .url(forID):
            return "\(IMAGESEARCH_PRE)/\(forID)\(IMAGESEARCH_POST)"
            
        case let .urlWithOutDefaultImage(forID):
            return "\(IMAGESEARCH_PRE)/\(forID)\(IMAGESEARCH_POST)\(IMAGESEARCH_FALSE_DEFAULT_PARAMETER)"
        }
    }
}
