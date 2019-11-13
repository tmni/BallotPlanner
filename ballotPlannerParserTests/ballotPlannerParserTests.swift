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
//  override init() {
//    super.init()
//    FirebaseApp.configure()
//  }
  
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
//    // create the expectation
//    let exp = expectation(description: "Loading ElectionDates")
//
//    // call my asynchronous method
//    parser1.electionDatesFromSearchResponse {_ in
//      // when it finishes, mark my expectation as being fulfilled
//      exp.fulfill()
//    }
//
//    // wait three seconds for all outstanding expectations to be fulfilled
//    waitForExpectations(timeout: 3)
    
    let electionDate1 = parser1.createElectionDate("date1", "description1", "name1")
    
    XCTAssertEqual(electionDate1.date, "date1")
    XCTAssertEqual(electionDate1.description, "description1")
    XCTAssertEqual(electionDate1.name, "name1")
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
    
    let achievement1 = parser2.createAchievement("name1", "description1", true)
    let achievement2 = parser2.createAchievement("name2", "description2", false)
    
    XCTAssertEqual(achievement1.name, "name1")
    XCTAssertEqual(achievement1.description, "description1")
    XCTAssertEqual(achievement1.isActive, true)
    
    XCTAssertEqual(achievement2.name, "name2")
    XCTAssertEqual(achievement2.description, "description2")
    XCTAssertEqual(achievement2.isActive, false)
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


