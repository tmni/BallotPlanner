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
      FirebaseApp.configure()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  func testElectionDatesFromSearchResponse(){
    
    
  }
  
//  db.collection("achievements").getDocuments() { (querySnapshot, err) in
//  if let err = err {
//  print("Error getting documents: \(err)")
//  } else {
//  for document in querySnapshot!.documents {
//  let newAchievement = Achievement(name: document.data()["name"] as! String, description: document.data()["description"] as! String, isActive: document.data()["isActive"] as! Bool)
//  print("adding ", newAchievement.name)
//  self.achievements.append(newAchievement)
//  }
//  }
//  completion(self.achievements)
//  }

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
    
    let db = Firestore.firestore()
    db.collection("achievements").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        var count = 0
        for document in querySnapshot!.documents {
          count += 1
        }
        XCTAssertEqual(self.parser2.achievements.count, count, "We should have loaded exactly 2 achievements.")
      }
    }
    
    // our expectation has been fulfilled, so we can check the result is correct
//    print(parser2.achievements.count)
//    XCTAssertEqual(parser2.achievements.count, 2, "We should have loaded exactly 2 achievements.")
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


