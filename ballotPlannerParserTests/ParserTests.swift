//
//  ParserTests.swift
//  ballotPlannerParserTests
//
//  Created by Erika Giuse on 12/2/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class ParserTests: XCTestCase {
    let parser = Parser()
  
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testCreateElectionDate() {
    let dict: Dictionary = ["hello": 1.00]
    let voting_locations: Array<Dictionary<String, Double>> = [dict]
    let electionDate = parser.createElectionDate("election_id", "date", "description", "name", voting_locations)
    
    XCTAssertEqual(electionDate.election_id, "election_id")
    XCTAssertEqual(electionDate.date, "date")
    XCTAssertEqual(electionDate.description, "description")
    XCTAssertEqual(electionDate.name, "name")
    XCTAssertEqual(electionDate.voting_locations, voting_locations)
  }
  
  func testCreateAchievement() {
    let achievement1 = parser.createAchievement("name1", "description1", true)
    let achievement2 = parser.createAchievement("name2", "description2", false)

    XCTAssertEqual(achievement1.name, "name1")
    XCTAssertEqual(achievement1.description, "description1")
    XCTAssertEqual(achievement1.isActive, true)

    XCTAssertEqual(achievement2.name, "name2")
    XCTAssertEqual(achievement2.description, "description2")
    XCTAssertEqual(achievement2.isActive, false)
  }
  
  func testCreateMyElection() {
    let myElection1 = parser.createMyElection("election_id", "date", "description", "name", [["lat": 0.0, "long": 1.1]])
    
    XCTAssertEqual(myElection1.election_id, "election_id")
    XCTAssertEqual(myElection1.date, "date")
    XCTAssertEqual(myElection1.description, "description")
    XCTAssertEqual(myElection1.name, "name")
    XCTAssertEqual(myElection1.voting_locations[0]["lat"], 0.0)
    XCTAssertEqual(myElection1.voting_locations[0]["long"], 1.1)
  }
  
  func testCreateBallotPerson() {
    let myBallot = parser.createBallotPerson("first_name", "last_name", "party_affiliation", nil, "contact_twitter", "summary", "people_id")
    
    XCTAssertEqual(myBallot.first_name, "first_name")
    XCTAssertEqual(myBallot.last_name, "last_name")
    XCTAssertEqual(myBallot.party_affiliation, "party_affiliation")
    XCTAssertEqual(myBallot.image, nil)
    XCTAssertEqual(myBallot.contact_twitter, "contact_twitter")
    XCTAssertEqual(myBallot.summary, "summary")
    XCTAssertEqual(myBallot.people_id, "people_id")
  }
  
  func testCreateCandidatePerson() {
    let myCandidatePerson = parser.createCandidatePerson("first_name", "last_name", "party_affiliation", nil, "contact_twitter", "summary", "people_id")
    
    XCTAssertEqual(myCandidatePerson.first_name, "first_name")
    XCTAssertEqual(myCandidatePerson.last_name, "last_name")
    XCTAssertEqual(myCandidatePerson.party_affiliation, "party_affiliation")
    XCTAssertEqual(myCandidatePerson.image, nil)
    XCTAssertEqual(myCandidatePerson.contact_twitter, "contact_twitter")
    XCTAssertEqual(myCandidatePerson.summary, "summary")
    XCTAssertEqual(myCandidatePerson.people_id, "people_id")
  }
}
