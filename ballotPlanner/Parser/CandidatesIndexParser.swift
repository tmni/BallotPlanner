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
  let group5 = DispatchGroup()
  let group6 = DispatchGroup()
  let group7 = DispatchGroup()
  let group8 = DispatchGroup()
  let group9 = DispatchGroup()
  
  var raceIdsFromElectionId = [String]()
  var raceIdsSortedByOfficeId = Dictionary<String, [String]>()
  //var candidateIds = [String]()
  var candidateIdsSortedByOfficeId = Dictionary<String, [String]>()
  //var peopleIds = [String]()
  var peopleIdsSortedByOfficeId = Dictionary<String, [String]>()
  
  var allCandidatesSortedByOfficeId = Dictionary<String, [Person]>()
  //var allCandidates = [Person]()
  
  var officeIdsToName = Dictionary<String, String>()
  
//  func getAllCandidates(completion: @escaping([Person]) -> Void) {
//    self.getRaceIdsFromElectionId {
//      (result) in
//      self.raceIdsFromElectionId = result
//      self.getCandidateIds {
//        (result) in
//        self.candidateIds = result
//        self.getPeopleIds {
//          (result) in
//          self.peopleIds = result
//          self.getCandidates {
//            (result) in
//            self.allCandidates = result
//            completion(self.allCandidates)
//          }
//        }
//      }
//    }
//  }
  
  func getAllCandidatesSortedByOfficeId(completion: @escaping(Dictionary<String, [Person]>) -> Void) {
    self.getRaceIdsFromElectionId {
      (result) in
      self.raceIdsFromElectionId = result
      self.getRaceIdsSortedByOfficeId {
        (result) in
        self.raceIdsSortedByOfficeId = result
        self.getCandidateIdsSortedByOfficeId() {
          (result) in
          self.candidateIdsSortedByOfficeId = result
          self.getPeopleIdsSortedByOfficeId {
            (result) in
            self.peopleIdsSortedByOfficeId = result
            self.getCandidatesSortedByOfficeId {
              (result) in
              self.allCandidatesSortedByOfficeId = result
              completion(self.allCandidatesSortedByOfficeId)
            }
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
  
  func getRaceIdsSortedByOfficeId(completion: @escaping(Dictionary<String, [String]>) -> Void) {
    let db = Firestore.firestore()
    self.group5.enter()
    db.collection("races").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group5.leave()
      } else {
        for document in querySnapshot!.documents {
          if (self.raceIdsFromElectionId.contains(document.documentID)) {
//            self.raceIdsSortedByOfficeId[document.get("office_id") as! String]?.append(document.documentID)
            if (self.raceIdsSortedByOfficeId.keys.contains(document.get("office_id") as! String)) {
              self.raceIdsSortedByOfficeId[document.get("office_id") as! String]?.append(document.documentID)
            } else {
              self.raceIdsSortedByOfficeId[document.get("office_id") as! String] = [document.documentID]
            }
          }
        }
        self.group5.leave()
      }
      completion(self.raceIdsSortedByOfficeId)
    }
  }
  
  // candidate ids from candidateRaces
//  func getCandidateIds(completion: @escaping([String]) -> Void) {
//    let db = Firestore.firestore()
//    self.group2.enter()
//    db.collection("candidateRace").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//        self.group2.leave()
//      } else {
//        for document in querySnapshot!.documents {
//          if (self.raceIdsFromElectionId.contains(document.get("race_id") as! String)) {
//            self.candidateIds.append(document.get("candidate_id") as! String)
//          }
//        }
//        self.group2.leave()
//      }
//      completion(self.candidateIds)
//    }
//  }
  
  func getCandidateIdsSortedByOfficeId(completion: @escaping(Dictionary<String, [String]>) -> Void) {
    let db = Firestore.firestore()
    self.group6.enter()
    db.collection("candidateRace").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group6.leave()
      } else {
        for document in querySnapshot!.documents {
          for key in self.raceIdsSortedByOfficeId.keys {
            if ((self.raceIdsSortedByOfficeId[key]?.contains(document.get("race_id") as! String))!) {
              if (self.candidateIdsSortedByOfficeId.keys.contains(key)) {
                self.candidateIdsSortedByOfficeId[key]?.append(document.get("candidate_id") as! String)
              } else {
                self.candidateIdsSortedByOfficeId[key] = [document.get("candidate_id") as! String]
              }
            }
          }
        }
        self.group6.leave()
      }
      completion(self.candidateIdsSortedByOfficeId)
    }
  }
  
  // people ids from candidates
//  func getPeopleIds(completion: @escaping([String]) -> Void) {
//    let db = Firestore.firestore()
//    self.group3.enter()
//    db.collection("candidates").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//        self.group3.leave()
//      } else {
//        for document in querySnapshot!.documents {
//          if (self.candidateIds.contains(document.documentID)) {
//            self.peopleIds.append(document.get("people_id") as! String)
//          }
//        }
//        self.group3.leave()
//      }
//      completion(self.peopleIds)
//    }
//  }
  
  func getPeopleIdsSortedByOfficeId(completion: @escaping(Dictionary<String, [String]>) -> Void) {
    let db = Firestore.firestore()
    self.group7.enter()
    db.collection("candidates").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group7.leave()
      } else {
        for document in querySnapshot!.documents {
          for key in self.candidateIdsSortedByOfficeId.keys {
            if ((self.candidateIdsSortedByOfficeId[key]?.contains(document.documentID))!) {
              if (self.peopleIdsSortedByOfficeId.keys.contains(key)) {
                self.peopleIdsSortedByOfficeId[key]?.append(document.get("people_id") as! String)
              } else {
                self.peopleIdsSortedByOfficeId[key] = [document.get("people_id") as! String]
              }
            }
          }
        }
        self.group7.leave()
      }
      completion(self.peopleIdsSortedByOfficeId)
    }
  }
  
  // get all candidate info, currently only info from the "people" document, but should be combined info from "candidate" and "people"
//  func getCandidates(completion: @escaping([Person]) -> Void) {
//    let db = Firestore.firestore()
//    self.group4.enter()
//    db.collection("people").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err):")
//        self.group4.leave()
//      } else {
//        for document in querySnapshot!.documents {
//          if self.peopleIds.contains(document.documentID) {
//            let newCandidatePerson = self.createCandidatePerson(document.get("first_name") as! String, document.get("last_name") as! String, document.get("party_affiliation") as! String, nil, document.get("contact_twitter") as! String, document.get("summary") as! String, document.documentID)
//            self.allCandidates.append(newCandidatePerson)
//          }
//        }
//        self.group4.leave()
//      }
//      completion(self.allCandidates)
//    }
//  }
  
  func getCandidatesSortedByOfficeId(completion: @escaping(Dictionary<String, [Person]>) -> Void) {
    let db = Firestore.firestore()
    self.group8.enter()
    db.collection("people").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group8.leave()
      } else {
        for document in querySnapshot!.documents {
          for key in self.peopleIdsSortedByOfficeId.keys {
            if ((self.peopleIdsSortedByOfficeId[key]?.contains(document.documentID))!) {
              let newCandidatePerson = self.createCandidatePerson(document.get("first_name") as! String, document.get("last_name") as! String, document.get("party_affiliation") as! String, nil, document.get("contact_twitter") as! String, document.get("summary") as! String, document.documentID)
              if (self.allCandidatesSortedByOfficeId.keys.contains(key)) {
                self.allCandidatesSortedByOfficeId[key]?.append(newCandidatePerson)
              } else {
                self.allCandidatesSortedByOfficeId[key] = [newCandidatePerson]
              }
            }
          }
        }
        self.group8.leave()
      }
      completion(self.allCandidatesSortedByOfficeId)
    }
  }
  
  func createCandidatePerson(_ first_name: String, _ last_name: String, _ party_affiliation: String, _ image: String?, _ contact_twitter: String, _ summary: String, _ people_id: String) -> Person{
    let newCandidatePerson = Person(first_name: first_name, last_name: last_name, party_affiliation: party_affiliation, image: image, contact_twitter: contact_twitter, summary: summary, people_id: people_id)
    return newCandidatePerson
  }
  
  func getOfficeIdsToName(_ allCandidatesSortedByOfficeId: Dictionary<String, [Person]>, completion: @escaping(Dictionary<String, String>) -> Void) {
    let db = Firestore.firestore()
    self.group9.enter()
    db.collection("offices").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group9.leave()
      } else {
        for document in querySnapshot!.documents {
          for key in allCandidatesSortedByOfficeId.keys {
            if (document.documentID == key) {
              self.officeIdsToName[key] = document.get("type") as! String
            }
          }
        }
        self.group9.leave()
      }
      completion(self.officeIdsToName)
    }
  }
  
}
