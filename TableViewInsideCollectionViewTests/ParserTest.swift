//
//  Parser.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/17/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import XCTest
@testable import TableViewInsideCollectionView

class ParserTest: XCTestCase {
    
    var parser : Parser!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        parser = Parser.sharedInstance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        parser = nil
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
    
    //MARK: - data(FromUnixTimeStamp:)
    
    func testDataFromUnixTimeStamp(){
        //Given
        let timeStamp1 : String = "-1013200168" // Result : 11/22/1937 @ 10:30pm (EST)
        let result1 : String = "November 23, 1937 UTC"
        let timestamp2 : String = "1502981883" // Result : August 17, 2017 @ 10:58:03 am
        let result2 : String = "August 17, 2017 UTC"
        let timestamp3 : String = "1483228800" // Result : December 31, 2016 @ 7:00:00 pm
        let result3 : String = "January 1, 2017 UTC"
        
        //When
        let check1 = parser.date(fromUnixTimeStamp: timeStamp1)
        let check2 = parser.date(fromUnixTimeStamp: timestamp2)
        let check3 = parser.date(fromUnixTimeStamp: timestamp3)
        
        //Then
        XCTAssertEqual(check1, result1, "Doesnot work for Negative time Stamp")
        XCTAssertEqual(check2, result2, "Doesnot work for a random time Stamp")
        XCTAssertEqual(check3, result3, "Doesnot work for a random time Stamp")
    }
    
    //MARK: - string(fromArray:)
    
    func testStringFromArray(){
        //Given
        let arrayWithOutAnyElements : [String] = []
        let expResultFor_arrayWithOutAnyElements = "Unknown"
        
        let arrayWithOneEmptyElement = [""]
        let expResultFor_arrayWithOneEmptyElement = "U"
        
        let arrayWithOneElement = ["Harry Potter"]
        let expResultFor_arrayWithOneElement = "Harry Potter"
        
        let arrayWithMoreElements = ["Ron Weisley", "Harry Potter", "Donald Trump"]
        let expResultFor_arrayWithMoreElements = "Ron Weisley, Harry Potter, Donald Trump"
        
        let arrayWithMoreElementsWithOneEmpty = ["Ron Weisley", "", "Donald Trump"]
        let expResultFor_arrayWithMoreElementsWithOneEmpty = "Ron Weisley, , Donald Trump"
        
        
        
        //When
        let actualResultFor_arrayWithOutAnyElements = parser.string(fromArray: arrayWithOutAnyElements)
        let actualResultFor_arrayWithOneEmptyElement = parser.string(fromArray: arrayWithOneEmptyElement)
        let actualResultFor_arrayWithOneElement = parser.string(fromArray: arrayWithOneElement)
        let actualResultFor_arrayWithMoreElements = parser.string(fromArray: arrayWithMoreElements)
        let actualResultFor_arrayWithMoreElementsWithOneEmpty = parser.string(fromArray: arrayWithMoreElementsWithOneEmpty)
        
        //Then
        XCTAssertEqual(actualResultFor_arrayWithOutAnyElements, expResultFor_arrayWithOutAnyElements, "Failed for Array With Out Any Elements")
        XCTAssertEqual(actualResultFor_arrayWithOneEmptyElement, expResultFor_arrayWithOneEmptyElement, "Failed for Array With One Empty Element")
        XCTAssertEqual(actualResultFor_arrayWithOneElement, expResultFor_arrayWithOneElement, "Failed for Array With One Element")
        XCTAssertEqual(actualResultFor_arrayWithMoreElements, expResultFor_arrayWithMoreElements, "Failed for Array With More Elements")
        XCTAssertEqual(actualResultFor_arrayWithMoreElementsWithOneEmpty, expResultFor_arrayWithMoreElementsWithOneEmpty, "Failed for Array With More Elements With One Empty")
        
    }
    
    func testworksArrayFromJsonSubjectData(){
        //Given
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "subjectMock", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as Any
            //Details from manual Data
        let expectedTitle = "Meditations"
        let expectedFullText = true
        let expectedLendingEdition = "OL24213774M"
        let expectedNumberOfEditions = 273
        let expectedFirstPublishedYear = "Unknown"
        
        
        //When
        let workArr = parser.worksArray(fromJsonSubjectData: json as Any)
        let work0 = workArr[0]
        
        //Then
        XCTAssertEqual(work0.title, expectedTitle)
        XCTAssertEqual(work0.hasFullText, expectedFullText)
        XCTAssertEqual(work0.lendingEdition_Medium, "olid/\(expectedLendingEdition)-M")
        XCTAssertEqual(work0.numberOfEditions, expectedNumberOfEditions)
        XCTAssertEqual(work0.firstPublishedYear, expectedFirstPublishedYear)
        
    
    }
}
