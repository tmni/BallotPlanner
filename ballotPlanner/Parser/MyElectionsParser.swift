//
//  MyElectionsParser.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/4/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class MyElectionsParser {
  
//  func getMyElection(_ raceElectionID: String, completion: @escaping(ElectionDate) -> Void) {
//    let db = Firestore.firestore()
//
//    db.collection("electionDates").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//      } else {
//        for document in querySnapshot!.documents {
//          if (document.documentID == raceElectionID) {
//            let myNewElection = ElectionDate(date: document.get("date") as! String, description: document.get("description") as! String, name: document.get("name") as! String)
//            completion(myNewElection)
//          }
//        }
//      }
//    }
//  }
//
//  func getRaceID(_ ballotRaceId: String, completion: @escaping(ElectionDate) -> Void) {
//    let db = Firestore.firestore()
//
//    var myNewElection = [ElectionDate]()
//    db.collection("races").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//      } else {
//        for document in querySnapshot!.documents {
//          if (document.documentID == ballotRaceId) {
////            completion(getMyElection(document.get("election_id") as! String, completion: { (myNewElec) in completion(myNewElec)}))
//              completion(
//                getMyElection { (myNewElec) in
//                  myNewElecion = myNewElec
//                  completion()
//                }
//              )
//          }
//        }
//      }
//    }
//  }
  
  
  
//  func myElectionsFromSearchResponse(completion: @escaping([ElectionDate]) -> Void) {
//    var myElectionsTotal = [ElectionDate]()
//    let db = Firestore.firestore()
//
//    db.collection("ballots").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Errors getting documents: \(err)")
//      } else {
//        for ballotDocument in querySnapshot!.documents {
//            db.collection("races").getDocuments() { (querySnapshot, err) in
//              if let err = err {
//                print("Errors getting documents: \(err)")
//              } else {
//                for raceDocument in querySnapshot!.documents {
//                  if (raceDocument.documentID == ballotDocument.data()["race_id"] as! String) {
//                    db.collection("electionDates").getDocuments() { (querySnapshot, err) in
//                      if let err = err {
//                        print("Errors getting documents: \(err)")
//                      } else {
//                        for electionDatesDocument in querySnapshot!.documents {
//                          if (electionDatesDocument.documentID == raceDocument.data()["election_id"] as! String) {
//                            let newMyElection = ElectionDate(date: electionDatesDocument.data()["date"] as! String, description: electionDatesDocument.data()["description"] as! String, name: electionDatesDocument.data()["name"] as! String)
//                            myElectionsTotal.append(newMyElection)
//                          }
//                        }
//                      }
//                    }
//                  }
//                }
//              }
//            }
//        }
//      }
//      completion(myElectionsTotal)
//    }
//
//  }
  
  let ballotsDispatchGroup = DispatchGroup()
  let racesDispatchGroup = DispatchGroup()
  let electionsDispatchGroup = DispatchGroup()
  let myElectionsDispatchGroup = DispatchGroup()
  
  var raceIdsFromBallots = [String]()
  var electionIdsFromBallots = [String]()
  var myElections = [ElectionDate]()
  
//  func myElectionsFromSearchResponse() -> [ElectionDate] {
//    self.myElectionsDispatchGroup.enter()
//    self.getRaceIdsFromBallots()
//    self.myElectionsDispatchGroup.leave()
//    print(myElections)
//    return myElections
//  }
  
  func getAllMyElections(completion: @escaping([ElectionDate]) -> Void) {
    self.getRaceIdsFromBallots{
      (result) in
      self.raceIdsFromBallots = result
      self.getElectionIdsFromRaces {
        (result) in
        self.electionIdsFromBallots = result
        self.getMyElections {
          (result) in
          self.myElections = result
          completion(self.myElections)
        }
      }
    }

  }
  
  func getRaceIdsFromBallots(completion: @escaping([String]) -> Void) {
    let db = Firestore.firestore()
    self.ballotsDispatchGroup.enter()
    db.collection("ballots").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.ballotsDispatchGroup.leave()
      } else {
        for document in querySnapshot!.documents {
          self.raceIdsFromBallots.append(document.get("race_id") as! String)
        }
        self.ballotsDispatchGroup.leave()
      }
      completion(self.raceIdsFromBallots)
    }
  }
  
  func getElectionIdsFromRaces(completion: @escaping([String]) -> Void) {
    let db = Firestore.firestore()
    self.racesDispatchGroup.enter()
    db.collection("races").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.racesDispatchGroup.leave()
      } else {
        for document in querySnapshot!.documents {
          if (self.raceIdsFromBallots.contains(document.documentID)) {
            self.electionIdsFromBallots.append(document.get("election_id") as! String)
          }
        }
        self.racesDispatchGroup.leave()
      }
      completion(self.electionIdsFromBallots)
    }
  }
  
  func getMyElections(completion: @escaping([ElectionDate]) -> Void) {
    //print(self.electionIdsFromBallots)
    let db = Firestore.firestore()
    self.electionsDispatchGroup.enter()
    db.collection("electionDates").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.electionsDispatchGroup.leave()
      } else {
        for document in querySnapshot!.documents {
          if (self.electionIdsFromBallots.contains(document.documentID)) {
            let myNewElection = ElectionDate(date: document.get("date") as! String, description: document.get("description") as! String, name: document.get("name") as! String)
            self.myElections.append(myNewElection)
          }
        }
        self.electionsDispatchGroup.leave()
      }
      completion(self.myElections)
    }
  }
  
}
