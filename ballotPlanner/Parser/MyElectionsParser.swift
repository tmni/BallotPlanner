////
////  MyElectionsParser.swift
////  ballotPlanner
////
////  Created by Erika Giuse on 11/4/19.
////  Copyright © 2019 Erika Giuse. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//class MyElectionsParser {
//
//  let ballotsDispatchGroup = DispatchGroup()
//  let racesDispatchGroup = DispatchGroup()
//  let electionsDispatchGroup = DispatchGroup()
//  let myElectionsDispatchGroup = DispatchGroup()
//
//  var raceIdsFromBallots = [String]()
//  var electionIdsFromBallots = [String]()
//  var myElections = [ElectionDate]()
//
//  let parser = Parser()
//  func getAllMyElections(completion: @escaping([ElectionDate]) -> Void) {
//    // have to reinitialize or results are always duplicated
//    self.raceIdsFromBallots = [String]()
//    self.electionIdsFromBallots = [String]()
//    self.myElections = [ElectionDate]()
//
//    self.getRaceIdsFromBallots{
//      (result) in
//      self.raceIdsFromBallots = result
//      self.getElectionIdsFromRaces {
//        (result) in
//        self.electionIdsFromBallots = result
//        self.getMyElections {
//          (result) in
//          self.myElections = result
//          completion(self.myElections)
//        }
//      }
//    }
//
//  }
//
//  func getRaceIdsFromBallots(completion: @escaping([String]) -> Void) {
//    let db = Firestore.firestore()
//    self.ballotsDispatchGroup.enter()
//    db.collection("ballots").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//        self.ballotsDispatchGroup.leave()
//      } else {
//        for document in querySnapshot!.documents {
//          self.raceIdsFromBallots.append(document.get("race_id") as! String)
//        }
//        self.ballotsDispatchGroup.leave()
//      }
//      completion(self.raceIdsFromBallots)
//    }
//  }
//
//  func getElectionIdsFromRaces(completion: @escaping([String]) -> Void) {
//    let db = Firestore.firestore()
//    self.racesDispatchGroup.enter()
//    db.collection("races").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//        self.racesDispatchGroup.leave()
//      } else {
//        for document in querySnapshot!.documents {
//          if (self.raceIdsFromBallots.contains(document.documentID)) {
//            self.electionIdsFromBallots.append(document.get("election_id") as! String)
//          }
//        }
//        self.racesDispatchGroup.leave()
//      }
//      completion(self.electionIdsFromBallots)
//    }
//  }
//
//  func getMyElections(completion: @escaping([ElectionDate]) -> Void) {
//    let db = Firestore.firestore()
//    self.electionsDispatchGroup.enter()
//    db.collection("electionDates").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//        self.electionsDispatchGroup.leave()
//      } else {
//        for document in querySnapshot!.documents {
//          if (self.electionIdsFromBallots.contains(document.documentID)) {
//            let myNewElection = self.parser.createMyElection(document.documentID, document.get("date") as! String, document.get("description") as! String, document.get("name") as! String, document.get("voting_locations") as! Array<Dictionary<String, Double>>)
//            self.myElections.append(myNewElection)
//          }
//        }
//        self.electionsDispatchGroup.leave()
//      }
//      completion(self.myElections)
//    }
//  }
//
//
//}
