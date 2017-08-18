//
//  FileManager.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/7/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation

class FileManager {
    
    public static let sharedInstance = FileManager()
    
    func loadSubjects() -> [String] {
        var returnObject = [String]()
        if let subjectPath = Bundle.main.path(forResource: "subjects", ofType: ".txt") {
            if let allSubjects = try? String(contentsOfFile: subjectPath){
                returnObject = allSubjects.components(separatedBy: "\n")
            }
        } else {
            returnObject = ["art","science","success","biographies","biographies","religion", "romance","textbooks"]
        }
        return returnObject
    }
}
