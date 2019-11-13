//
//  PageViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/12/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit

class ElectionsPageViewController: UIPageViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    dataSource = self
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
    }
    
  }
  var viewModel: ElectionDateDetailViewModel?
  
  private(set) lazy var orderedViewControllers: [UIViewController] = {
    return [self.newViewController("ElectionDateDetail"),
            self.newViewController("CandidatesIndex")]
  }()

  private func newViewController(_ name: String) -> UIViewController {
    return UIStoryboard(name: "ElectionDates", bundle: nil) .instantiateViewController(withIdentifier: name)
  }
  
}

extension ElectionsPageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    return nil
  }

  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    return nil
  }
  
}


