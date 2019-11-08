//
//  AchievementsViewModelTests.swift
//  ballotPlannerViewModelTests
//
//  Created by Taruna Emani on 11/8/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import XCTest
@testable import ballotPlanner

class AchievementsViewModelTests: XCTestCase {

  func testRefresh() {
    
    }
  
  func testNumberOfRows() {
    let achievements = [createAchievement(), createAchievement(), createAchievement()]
    let viewModel = AchievementViewModel()
    viewModel.achievements = achievements
    
    XCTAssertEqual(viewModel.numberOfRows(), 3)
      }
  
  func testNameForRowAtIndexPath() {
    let a1 = createAchievement()
    let a2 = Achievement( name: "YUH", description: "wow", isActive: true)
    let achs = [a1, a2]
    let viewModel = AchievementViewModel()
    viewModel.achievements = achs
    
    let indexPath1 = IndexPath(row: 0, section: 0)
    XCTAssertEqual(viewModel.nameForRowAtIndexPath(indexPath1), "Voted")
    
    let indexPath2 = IndexPath(row: 1, section: 0)
    XCTAssertEqual(viewModel.nameForRowAtIndexPath(indexPath2), "YUH")
    
    let indexPath3 = IndexPath(row: 99, section: 99)
    XCTAssertEqual(viewModel.nameForRowAtIndexPath(indexPath3), "")
  }
  func testDescForRowAtIndexPath() {
    let a1 = createAchievement()
    let a2 = Achievement( name: "YUH", description: "wow", isActive: true)
    let achs = [a1, a2]
    let viewModel = AchievementViewModel()
    viewModel.achievements = achs
    
    let indexPath1 = IndexPath(row: 0, section: 0)
    XCTAssertEqual(viewModel.descForRowAtIndexPath(indexPath1), "I voted")
    
    let indexPath2 = IndexPath(row: 1, section: 0)
    XCTAssertEqual(viewModel.descForRowAtIndexPath(indexPath2), "wow")
    
    let indexPath3 = IndexPath(row: 99, section: 99)
    XCTAssertEqual(viewModel.descForRowAtIndexPath(indexPath3), "")
  }
  
  
  
  func testGetAchNames(){
    let a1 = createAchievement()
    let a2 = Achievement( name: "YUH", description: "wow", isActive: true)
    let achs = [a1, a2]
    let viewModel = AchievementViewModel()
    viewModel.achievements = achs
    XCTAssertEqual(viewModel.getAchNames(), ["Voted", "YUH"])
    
  }
  func testGetAchDescs() {
    let a1 = createAchievement()
    let a2 = Achievement( name: "YUH", description: "wow", isActive: true)
    let achs = [a1, a2]
    let viewModel = AchievementViewModel()
    viewModel.achievements = achs
    XCTAssertEqual(viewModel.getAchDescs(), ["I voted", "wow"])
  }
  
  func createAchievement() -> Achievement{
    let a = Achievement(name: "Voted", description: "I voted", isActive: true)
    return a
    
  }
  



}
