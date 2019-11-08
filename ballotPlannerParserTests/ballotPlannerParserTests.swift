//
//  ballotPlannerParserTests.swift
//  ballotPlannerParserTests
//
//  Created by Taruna Emani on 11/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
import Firebase
@testable import ballotPlanner

class ballotPlannerParserTests: XCTestCase {
  let parser1 = ElectionDatesParser()
  let parser2 = AchievementParser()
  let parser3 = MyElectionsParser()
  let parser4 = UserInfoParser()
  

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  func testElectionDatesFromSearchResponse(){
    
    
  }
  
  

  func testAchievementsFromSearchResponse() {
    
    // create the expectation
    let exp = expectation(description: "Loading Achievements")
    
    // call my asynchronous method
    parser2.AchievementsFromSearchResponse {_ in
      // when it finishes, mark my expectation as being fulfilled
      exp.fulfill()
    }
    
    // wait three seconds for all outstanding expectations to be fulfilled
    waitForExpectations(timeout: 3)
    
    // our expectation has been fulfilled, so we can check the result is correct
    print(parser2.achievements.count)
    XCTAssertEqual(parser2.achievements.count, 2, "We should have loaded exactly 2 achievements.")
  }
  
  func testGetAllMyElections(){}
  func testGetRaceIdsFromBallots(){}
  func testGetElectionIdsFromRaces(){}
  func testGetMyElections(){}
  func testDataFromSearchResponse(){}
  


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


