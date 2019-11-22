//
//  ballotPlannerModelTests.swift
//  ballotPlannerModelTests
//
//  Created by Taruna Emani on 11/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
import Firebase
@testable import ballotPlanner

class ballotPlannerModelTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testElectionDate() {
    let wow = ElectionDate(election_id: "election_id", date: "Thisisadate", description: "Thisisadescription", name: "Name", voting_locations: [["lat": 0.0, "long": 1.1]])
    XCTAssertTrue(wow.date == "Thisisadate")
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  func testPerson() {
    let first_name = "Bob"
    let last_name = "Smith"
    let party_affiliation = "Democratic"
    let summary = "This is a summary"
    let image = "wow.png"
    let people_id = "people_id"
    
    let wow = Person(first_name: first_name, last_name: last_name, party_affiliation: party_affiliation, image: image, contact_twitter: "contact_twitter",  summary: summary, people_id: "people_id" )
    XCTAssertTrue(wow.first_name == "Bob")
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testAchievement() {
    let name = "Voted"
    let description = "You voted"
    let isActive = true
    let wow = Achievement(name: name, description: description, isActive: isActive)
    XCTAssertTrue(wow.name == "Voted")
    
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}