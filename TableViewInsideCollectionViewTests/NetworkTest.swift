//
//  NetworkTest.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/17/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import XCTest
@testable import TableViewInsideCollectionView

class NetworkTest: XCTestCase {
    
    var network : Network!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = Network.sharedInstance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        network = nil
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            self.testDownloadJSON2_ForSearchCompletionHandler()
        }
    }
    
    //MARK: -  downloadJSON2 Test functions
    
    func testDownloadJSON2_ForSearchCompletionHandler(){
        //Given
        let urlText = "https://openlibrary.org/search.json?q=pokemon&has_fulltext=true"
        let promise = expectation(description: "Downloaded data successfully and ready to be parsed")
        
        //When
        network.downloadJSON2(from: urlText) { _ in
        //Then
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadJSON2_verifyData(){
        //Given
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "subjectMock", ofType: "json")
        let exectedData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) as Any
        //When
        network.downloadJSON2(from: "https://openlibrary.org/subjects/religion.json") { (downloadedData) in
            //Then
            let expected = NSData(data: exectedData as! Data)
            let downloaded = NSData(data: downloadedData as! Data)
            
            XCTAssert(expected.isEqual(downloaded))
        }
    }

     //MARK: -  getImageFromWeb Test Functions
    
    func testGetImageFromWeb_ForSuccessfulDownload(){
        //Given
        let urlText = "http://covers.openlibrary.org/b/id/474323-M.jpg"
        let promise = expectation(description: "Downloaded image successfully and ready for used")
        
        //When
        network.getImageFromWeb(urlText) { (_) in
        //Then
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
//    func testGetImageFromWeb_ForImageVerification(){
//        //Given
//        let urlText = "http://covers.openlibrary.org/b/id/474323-M.jpg"
//        let promise = expectation(description: "Downloaded image successfully and ready for used")
//        
//        //When
//        network.getImageFromWeb(urlText) { (downloadedImage) in
//            //Then
//            guard let expectedImage = UIImage(named : "cover_trial") else {
//                XCTFail("Trial Image Not found!!!")
//                return
//            }
//            
//            if (downloadedImage?.isEqual(expectedImage))! {
//                promise.fulfill()
//            } else {
//                XCTFail("The Image downloades is not the expected image")
//            }
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
    
}
