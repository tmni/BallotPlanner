//
//  ballotPlannerParserTests.swift
//  ballotPlannerParserTests
//
//  Created by Erika Giuse on 11/13/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
import Firebase
@testable import ballotPlanner

class ballotPlannerParserTests: XCTestCase {

    let parser1 = ElectionDatesParser()
    let parser2 = AchievementParser()
    let parser3 = MyElectionsParser()
    let parser4 = MyBallotsParser(ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: [["lat": 0.0, "long": 1.1]]))
    let parser5 = CandidatesIndexParser(ElectionDate(election_id: "election_id", date: "date", description: "description", name: "name", voting_locations: [["lat": 0.0, "long": 1.1]]))
  
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
    
    let electionDate1 = parser1.createElectionDate("election_id1", "date1", "description1", "name1", [["lat": 0.0, "long": 1.1]])
    
    XCTAssertEqual(electionDate1.election_id, "election_id1")
    XCTAssertEqual(electionDate1.date, "date1")
    XCTAssertEqual(electionDate1.description, "description1")
    XCTAssertEqual(electionDate1.name, "name1")
    XCTAssertEqual(electionDate1.voting_locations[0]["lat"], 0.0)
    XCTAssertEqual(electionDate1.voting_locations[0]["long"], 1.1)
  }
  
  func testAchievementsFromSearchResponse() {
    let achievement1 = parser2.createAchievement("name1", "description1", true)
    let achievement2 = parser2.createAchievement("name2", "description2", false)
    
    XCTAssertEqual(achievement1.name, "name1")
    XCTAssertEqual(achievement1.description, "description1")
    XCTAssertEqual(achievement1.isActive, true)
    
    XCTAssertEqual(achievement2.name, "name2")
    XCTAssertEqual(achievement2.description, "description2")
    XCTAssertEqual(achievement2.isActive, false)
  }
  
  func testMyElectionsParser() {
    let myElection1 = parser3.createMyElection("election_id", "date", "description", "name", [["lat": 0.0, "long": 1.1]])
    
    XCTAssertEqual(myElection1.election_id, "election_id")
    XCTAssertEqual(myElection1.date, "date")
    XCTAssertEqual(myElection1.description, "description")
    XCTAssertEqual(myElection1.name, "name")
    XCTAssertEqual(myElection1.voting_locations[0]["lat"], 0.0)
    XCTAssertEqual(myElection1.voting_locations[0]["long"], 1.1)
  }
  
  func testMyBallotParser() {
    let myBallot = parser4.createBallotPerson("first_name", "last_name", "party_affiliation", nil, "contact_twitter", "summary", "people_id")
    
    XCTAssertEqual(myBallot.first_name, "first_name")
    XCTAssertEqual(myBallot.last_name, "last_name")
    XCTAssertEqual(myBallot.party_affiliation, "party_affiliation")
    XCTAssertEqual(myBallot.image, nil)
    XCTAssertEqual(myBallot.contact_twitter, "contact_twitter")
    XCTAssertEqual(myBallot.summary, "summary")
    XCTAssertEqual(myBallot.people_id, "people_id")
  }
  
  func testCandidatesIndexParser() {
    let myCandidatePerson = parser5.createCandidatePerson("first_name", "last_name", "party_affiliation", nil, "contact_twitter", "summary", "people_id")
    
    XCTAssertEqual(myCandidatePerson.first_name, "first_name")
    XCTAssertEqual(myCandidatePerson.last_name, "last_name")
    XCTAssertEqual(myCandidatePerson.party_affiliation, "party_affiliation")
    XCTAssertEqual(myCandidatePerson.image, nil)
    XCTAssertEqual(myCandidatePerson.contact_twitter, "contact_twitter")
    XCTAssertEqual(myCandidatePerson.summary, "summary")
    XCTAssertEqual(myCandidatePerson.people_id, "people_id")
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

}
