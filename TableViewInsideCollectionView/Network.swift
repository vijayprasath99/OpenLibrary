//
//  Network.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 7/31/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation

class Network{
    static let sharedInstance = Network()
    
    func downloadJSON(from : String){
        
        guard let jsonURL = URL(string: from) else {
            print("Something wrong with parsing URL")
            return
        }
        
        URLSession.shared.dataTask(with: jsonURL) { (data, response, err) in
            if err != nil {
                print("Something wrong with the URL Session ",err.debugDescription)
                return
            }
            
            do {
                guard let data = data else {
                    print("Something wrong with the data in URL Session")
                    return
                }
                
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
            } catch let jsonErr {
                print(jsonErr.localizedDescription)
            }
        }.resume()
        
    }
}
