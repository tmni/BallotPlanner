//
//  MyBallotsParser.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class MyBallotsParser {
  var election: ElectionDate
  
  init(_ election: ElectionDate) {
    self.election = election
  }
  
  // TODO: go through all raceIds in ballots
  // go through all races for those raceIds
  // if race's election_id matches given electionID
  // then for each race loop through all candidate races to get candidateRaces that matches race id
  // for each candidate race, get candidate, then people_id
  
  // loop through all races, get races that match the given election id
  // for each race, loop through all candidate races that match the race id
  // for each candidate race, get candidate, then people_id
  // get first and last name of people, then detail view controller is candidate show
  
  let group1 = DispatchGroup()
  let group2 = DispatchGroup()
  let group3 = DispatchGroup()
  let group4 = DispatchGroup()
  
  var raceIdsFromElectionId = [String]()
  var candidateIds = [String]()
  var peopleIds = [String]()
  var myBallots = [Person]()
  
  func getAllMyBallots(completion: @escaping([Person]) -> Void) {
    self.getRaceIdsFromElectionId {
      (result) in
      self.raceIdsFromElectionId = result
      self.getCandidateIds {
        (result) in
        self.candidateIds = result
        self.getPeopleIds {
          (result) in
          self.peopleIds = result
          self.getBallotCandidates {
            (result) in
            self.myBallots = result
            completion(self.myBallots)
          }
        }
      }
    }
  }
  
  func getRaceIdsFromElectionId(completion: @escaping([String]) -> Void) {
    let db = Firestore.firestore()
    self.group1.enter()
    db.collection("races").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group1.leave()
      } else {
        for document in querySnapshot!.documents {
          if (document.get("election_id") as! String == self.election.election_id) {
            self.raceIdsFromElectionId.append(document.documentID)
          }
        }
        self.group1.leave()
      }
      completion(self.raceIdsFromElectionId)
    }
  }
  
  //TODO: get candidate ids from ballots, then people from candidates
  
  // candidate ids from candidateRaces
  func getCandidateIds(completion: @escaping([String]) -> Void) {
    let db = Firestore.firestore()
    self.group2.enter()
    db.collection("candidateRaces").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group2.leave()
      } else {
        for document in querySnapshot!.documents {
          if (self.raceIdsFromElectionId.contains(document.get("race_id") as! String)) {
            self.candidateIds.append(document.get("candidate_id") as! String)
          }
        }
        self.group2.leave()
      }
      completion(self.candidateIds)
    }
  }
  
  // people ids from candidates
  func getPeopleIds(completion: @escaping([String]) -> Void) {
    let db = Firestore.firestore()
    self.group3.enter()
    db.collection("candidates").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group3.leave()
      } else {
        for document in querySnapshot!.documents {
          if (self.candidateIds.contains(document.documentID)) {
            self.peopleIds.append(document.get("people_id") as! String)
          }
        }
        self.group3.leave()
      }
      completion(self.peopleIds)
    }
  }
  
  func getBallotCandidates(completion: @escaping([Person]) -> Void) {
    let db = Firestore.firestore()
    self.group4.enter()
    db.collection("people").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err):")
        self.group4.leave()
      } else {
        for document in querySnapshot!.documents {
//          let newBallotCandidate = Candidate(first_name: document.get("first_name") as! String, last_name: document.get("last_name") as! String)
          let newBallotPerson = Person(first_name: document.get("first_name") as! String, last_name: document.get("last_name") as! String, party_affiliation: document.get("party_affiliation") as! String, image: nil, contact_twitter: document.get("contact_twitter") as! String, summary: document.get("summary") as! String)
          self.myBallots.append(newBallotPerson)
        }
        self.group4.leave()
      }
      completion(self.myBallots)
    }
  }
  
}
