//
//  WorkTest.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/17/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import XCTest
@testable import TableViewInsideCollectionView

class WorkTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWork(){
        //Given
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "MockWork", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : Any]
        
        //When
        let work : Work = Work(jsonArray: json!)
        
        //Then
        XCTAssertEqual(work.title, "Pokemon")
        XCTAssertEqual(work.title_suggest, "Pokemon")
        XCTAssertEqual(work.subtitle, "Pikachu's Rescue Adventure")
        XCTAssertEqual(work.authors, ["Tracey West"])
        XCTAssertEqual(work.hasFullText, true)
        XCTAssertEqual(work.firstPublishedYear, "1999")
        XCTAssertEqual(work.coverIdMedium, "olid/OL7510361M-M")
        XCTAssertEqual(work.numberOfEditions, 3)
        XCTAssertEqual(work.numberOfEbooks, 1)
        XCTAssertEqual(work.goodReadID, ["1480256","1011074","454771"])
        XCTAssertEqual(work.libraryThingID, ["1558733","749602","441844"])
        XCTAssertEqual(work.isbn, ["0439137411","9780439137416","9780439199681","0439199689", "9780439199698","0439199697"])
        
    }
    
}
