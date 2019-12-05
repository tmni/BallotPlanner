//
//  MyBallotsViewModel.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class MyBallotsParser {
  var election: ElectionDate
  let parser = Parser()
  
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
  
  let group2 = DispatchGroup()
  let group3 = DispatchGroup()
  let group4 = DispatchGroup()
  let group5 = DispatchGroup()
  let group6 = DispatchGroup()
  
  var raceIdsFromBallots = [String]()
  var filteredRaceIdsByElectionID = [String]()
  var candidateIds = [String]()
  var peopleIds = [String]()
  var myBallots = [Person]()
  
  func getAllMyBallots(completion: @escaping([Person]) -> Void) {
    //self.getRaceIdsFromElectionId {
    self.getRaceIdsFromBallots {
      (result) in
      self.raceIdsFromBallots = result
      self.getFilteredRaceIdsByElectionID {
        (result) in
        //self.raceIdsFromElectionId = result
        self.filteredRaceIdsByElectionID = result
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
  }
  
  func getRaceIdsFromBallots (completion: @escaping([String]) -> Void)  {
    let db = Firestore.firestore()
    self.group5.enter()
    db.collection("ballots").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group5.leave()
      } else {
        for document in querySnapshot!.documents {
          self.raceIdsFromBallots.append(document.get("race_id") as! String)
        }
        self.group5.leave()
      }
      completion(self.raceIdsFromBallots)
    }
  }
  
  func getFilteredRaceIdsByElectionID (completion: @escaping([String]) -> Void) {
    let db = Firestore.firestore()
    self.group6.enter()
    db.collection("races").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group6.leave()
      } else {
        for document in querySnapshot!.documents {
          if (self.raceIdsFromBallots.contains(document.documentID) && (document.get("election_id") as! String == self.election.election_id)) {
            self.filteredRaceIdsByElectionID.append(document.documentID)
          }
        }
        self.group6.leave()
      }
      completion(self.filteredRaceIdsByElectionID)
    }
  }
  
  // candidate ids from ballots (where the ballot has a race id belonging to given election
  func getCandidateIds(completion: @escaping([String]) -> Void) {
    let db = Firestore.firestore()
    self.group2.enter()
    db.collection("ballots").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group2.leave()
      } else {
        for document in querySnapshot!.documents {
          if (self.filteredRaceIdsByElectionID.contains(document.get("race_id") as! String)) {
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
          if (self.peopleIds.contains(document.documentID)) {
            let newBallotPerson = self.parser.createBallotPerson(document.get("first_name") as! String, document.get("last_name") as! String, document.get("party_affiliation") as! String, nil, document.get("contact_twitter") as! String, document.get("summary") as! String, document.documentID)
            self.myBallots.append(newBallotPerson)
          }
        }
        self.group4.leave()
      }
      completion(self.myBallots)
    }
  }
  
}

class MyBallotsViewModel {
  var election: ElectionDate
  
  init(election: ElectionDate) {
    self.election = election
  }
  
  var myBallots = [Person]()
  
  func numberOfRows() -> Int {
    return myBallots.count
  }
  
  func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    if (row >= self.numberOfRows()) {
      return ""
    }
    else {
      let myBallot = myBallots[row]
      return myBallot.first_name + " " + myBallot.last_name
    }
  }
  
  func candidateViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> CandidateViewModel {
    return CandidateViewModel(candidate: myBallots[indexPath.row])
  }
  
  func refresh(_ completion: @escaping () -> Void) {
    let parser = MyBallotsParser(self.election)
    
    parser.getAllMyBallots {
      (result) in self.myBallots = result
      completion()
    }
  }
}
