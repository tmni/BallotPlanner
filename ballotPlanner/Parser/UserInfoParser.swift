//
//  UserInfoParser.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

//class UserInfoParser {
//
//  func DataFromSearchResponse(completion: @escaping((String, Int)) -> Void) {
//    var user_info: (String, Int) = (party: "", zip: 0)
//    let db = Firestore.firestore()
//    db.collection("user").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//        print("Error getting documents: \(err)")
//      } else {
//        for document in querySnapshot!.documents {
//          if document.documentID == "okabUm7jCq34tjDWHbRQ"{
//            let party = document.data()["party"]
//
//            let zip = document.data()["zip"]
//            user_info.0 = party as! String
//            user_info.1 = zip as! Int
//
//          }
//        }
//      }
//      completion(user_info)
//    }
//  }
//
//}

