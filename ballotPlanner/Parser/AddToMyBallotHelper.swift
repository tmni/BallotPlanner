//
//  AddToMyBallotHelper.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

// Creates a new "ballots" table entry

class AddToMyBallotHelper {
  var person: Person
  
  init(_ person: Person) {
    self.person = person
  }
  
  // given the person_id, loop through candidates to get the correct candidate
  // loop through all candidateRaces, find the one that matches candidate_id, get race_id
  // create a new candidate document with the candidate_id and race_id
  
  let group1 = DispatchGroup()
  let group2 = DispatchGroup()
  
  var candidate_id = ""
  var race_id = ""
  
  func addToMyBallot() {
    let db = Firestore.firestore()
    self.getCandidateId {
      (result) in
      self.candidate_id = result
      self.getRaceId {
        (result) in
        self.race_id = result
        var ref: DocumentReference? = nil
        ref = db.collection("ballots").addDocument(data: ["candidate_id": self.candidate_id, "race_id": self.race_id, "user_id": "okabUm7jCq34tjDWHbRQ" ]) { err in
          if let err = err {
            print("Error adding document: \(err)")
          } else {
            print("Document added with ID: \(ref!.documentID)")
          }
        }
      }
    }
  }

  func getCandidateId(completion: @escaping(String) -> Void) {
    let db = Firestore.firestore()
    self.group1.enter()
    db.collection("candidates").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group1.leave()
      } else {
        for document in querySnapshot!.documents {
          if (document.get("people_id") as! String == self.person.people_id) {
            self.candidate_id = document.documentID
          }
        }
        self.group1.leave()
      }
      completion(self.candidate_id)
    }
  }
  
  func getRaceId(completion: @escaping(String) -> Void) {
    let db = Firestore.firestore()
    self.group2.enter()
    db.collection("candidateRace").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Errors getting documents: \(err)")
        self.group2.leave()
      } else {
        for document in querySnapshot!.documents {
          if (document.get("candidate_id") as! String == self.candidate_id) {
            self.race_id = document.get("race_id") as! String
          }
        }
        self.group2.leave()
      }
      completion(self.race_id)
    }
  }
  
}
