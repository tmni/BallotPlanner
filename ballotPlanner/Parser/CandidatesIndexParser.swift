//
//  CandidatesIndexParser.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class CandidatesIndexParser {
  var election: ElectionDate
  
  init(_ election: ElectionDate) {
    self.election = election
  }
  
  // loop through all races, get race_ids that match given election id
  // loop through all candidateRaces, get candidate_ids that match race_id
  // loop through all candidates, get people
  
  let group1 = DispatchGroup()
  let group2 = DispatchGroup()
  let group3 = DispatchGroup()
  let group4 = DispatchGroup()
  
  var raceIdsFromElectionId = [String]()
  var candidateIds = [String]()
  var peopleIds = [String]()
  var allCandidates = [Person]()
  
  func getAllCandidates(completion: @escaping([Person]) -> Void) {
    self.getRaceIdsFromElectionId {
      (result) in
      self.raceIdsFromElectionId = result
      self.getCandidateIds {
        (result) in
        self.candidateIds = result
        self.getPeopleIds {
          (result) in
          self.peopleIds = result
          self.getCandidates {
            (result) in
            self.allCandidates = result
            completion(self.allCandidates)
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
  
  func getCandidates(completion: @escaping([Person]) -> Void) {
    let db = Firestore.firestore()
    self.group4.enter()
    db.collection("people").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err):")
        self.group4.leave()
      } else {
        for document in querySnapshot!.documents {
          //          let newBallotCandidate = Candidate(first_name: document.get("first_name") as! String, last_name: document.get("last_name") as! String)
//          let newCandidatePerson = Person(first_name: document.get("first_name") as! String, last_name: document.get("last_name") as! String, party_affiliation: document.get("party_affiliation") as! String, image: nil, contact_twitter: document.get("contact_twitter") as! String, summary: document.get("summary") as! String, people_id: document.documentID)
          let newCandidatePerson = self.createCandidatePerson(document.get("first_name") as! String, document.get("last_name") as! String, document.get("party_affiliation") as! String, nil, document.get("contact_twitter") as! String, document.get("summary") as! String, document.documentID)
          self.allCandidates.append(newCandidatePerson)
        }
        self.group4.leave()
      }
      completion(self.allCandidates)
    }
  }
  
  func createCandidatePerson(_ first_name: String, _ last_name: String, _ party_affiliation: String, _ image: String?, _ contact_twitter: String, _ summary: String, _ people_id: String) -> Person{
    let newCandidatePerson = Person(first_name: first_name, last_name: last_name, party_affiliation: party_affiliation, image: image, contact_twitter: contact_twitter, summary: summary, people_id: people_id)
    return newCandidatePerson
  }
  
}
