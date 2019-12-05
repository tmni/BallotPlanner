//
//  Parser.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 12/2/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

class Parser {
  func createElectionDate(_ election_id: String, _ date: String, _ description: String, _ name: String, _ voting_locations: Array<Dictionary<String, Double>>) -> ElectionDate {
    let newElectionDate = ElectionDate(election_id: election_id, date: date, description: description, name: name, voting_locations: voting_locations)
    return newElectionDate
  }
  
  func createAchievement(_ name: String, _ description: String, _ isActive: Bool) -> Achievement {
    let newAchievement = Achievement(name: name, description: description, isActive: isActive)
    return newAchievement
  }

  func createMyElection(_ election_id: String, _ date: String, _ description: String, _ name: String, _ voting_locations: Array<Dictionary<String, Double>>) -> ElectionDate {
    let newElectionDate = ElectionDate(election_id: election_id, date: date, description: description, name: name, voting_locations: voting_locations)
    return newElectionDate
  }

  func createBallotPerson(_ first_name: String, _ last_name: String, _ party_affiliation: String, _ image: String?, _ contact_twitter: String, _ summary: String, _ people_id: String) -> Person{
    let newBallotPerson = Person(first_name: first_name, last_name: last_name, party_affiliation: party_affiliation, image: image, contact_twitter: contact_twitter, summary: summary, people_id: people_id)
    return newBallotPerson
  }

  func createCandidatePerson(_ first_name: String, _ last_name: String, _ party_affiliation: String, _ image: String?, _ contact_twitter: String, _ summary: String, _ people_id: String) -> Person{
    let newCandidatePerson = Person(first_name: first_name, last_name: last_name, party_affiliation: party_affiliation, image: image, contact_twitter: contact_twitter, summary: summary, people_id: people_id)
    return newCandidatePerson
  }
  
}
