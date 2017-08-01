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
 
//    func downloadJSON(from : String) -> Any{
//        var json : Any?
//        
//        guard let jsonURL = URL(string: from) else {
//            print("Something wrong with parsing URL")
//            return json as Any
//        }
//        
//        URLSession.shared.dataTask(with: jsonURL) { (data, response, err) in
//            if err != nil {
//                print("Something wrong with the URL Session ",err.debugDescription)
//                return
//            }
//            do {
//                guard let data = data else {
//                    print("Something wrong with the data in URL Session")
//                    return
//                }
//                json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json as Any)
//            } catch let jsonErr {
//                print(jsonErr.localizedDescription)
//            }
//        }.resume()
//        return json as Any
//    }
//    
    func downloadJSON2(from : String, completion : @escaping DownloadComplete){
        
        guard let jsonURL = URL(string: from) else {
            print("Something wrong with parsing URL -> \(from)")
            return
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: jsonURL) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    completion(json)
                } catch let jsonErr {
                    print(jsonErr.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
