//
//  Network.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 7/31/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import Foundation
import UIKit

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
            print("Network.swift | downloadJSON2 | Err : Something wrong with parsing URL -> \(from)")
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
                    print("Network.swift | downloadJSON2(from:) | Err : Something wrong with JSON SERIALIZATION -> \(jsonErr)")
                }
            }
        }
        task.resume()
    }
    
    func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            print("File : BookTVCell.swift | Func : getImageFromWeb | Err : Something wrong URL Conversion :  ")
            return closure(nil)
        }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("File : BookTVCell.swift | Func : getImageFromWeb | Err : \(String(describing: error))")
                return closure(nil)
            }
            guard response != nil else {
                print("File : BookTVCell.swift | Func : getImageFromWeb | Err : no response")
                return closure(nil)
            }
            guard data != nil else {
                print("File : BookTVCell.swift | Func : getImageFromWeb | Err : no data")
                return closure(nil)
            }
            DispatchQueue.main.async {
                closure(UIImage(data: data!))
            }
        }; task.resume()
    }
}
