//
//  MyBallotsViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

class MyBallotsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  
  var viewModel: MyBallotsViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedRow = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedRow, animated: true)
    }
    
    let cellNib = UINib(nibName: "MyBallotsTableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "myBallotCell")
    
    viewModel?.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailVC = segue.destination as? CandidateViewController,
      let indexPath = sender as? IndexPath {
      detailVC.viewModel = viewModel?.candidateViewModelForRowAtIndexPath(indexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.numberOfRows() ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myBallotCell", for: indexPath) as! MyBallotsTableViewCell
    cell.name.text = viewModel?.titleForRowAtIndexPath(indexPath)
    if (cell.name.text == "Michael Lamb") {
      cell.position.text = "Controller"
    } else {
      cell.position.text = "City Council District 1"
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toCandidateVC", sender: indexPath)
  }
}
