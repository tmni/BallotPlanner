//
//  ElectionDatesViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

class ElectionDatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  
  let viewModel = ElectionDatesViewModel()
  let cellSpacingHeight: CGFloat = 5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "cell")
    
    viewModel.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedRow = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedRow, animated: true)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailVC = segue.destination as? ElectionDateDetailViewController,
      let indexPath = sender as? IndexPath {
      detailVC.viewModel = viewModel.detailViewModelForRowAtIndexPath(indexPath)
      //detailVC.electionDate = viewModel.electionDates[indexPath.row]
    }
//    if let detailVC = segue.destination as? CandidatesIndexViewController,
//      let indexPath = sender as? IndexPath {
//      detailVC.viewModel = viewModel.candidatesIndexViewModelForRowAtIndexPath(indexPath)
//    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
    cell.name.text = viewModel.titleForRowAtIndexPath(indexPath)
    cell.date.text = "Voting Day: " + viewModel.dateForRowAtIndexPath(indexPath)
    
//    cell.layer.borderWidth = CGFloat(10)
////    cell.layer.borderColor = tableView.backgroundColor?.cgColor
    
    cell.layer.cornerRadius = 10
    cell.layer.masksToBounds = false
    cell.layer.shadowColor = UIColor.white.cgColor
    cell.layer.shadowOffset = CGSize(width: 5, height: 5);
    cell.layer.shadowOpacity = 0.5
//    cell.layer.borderWidth = 10
//    cell.layer.borderColor = UIColor(red:0.31, green:0.66, blue:0.96, alpha:1.0).cgColor
    cell.layer.borderWidth = 5
    cell.layer.borderColor = tableView.backgroundColor?.cgColor
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toDetailVC", sender: indexPath)
  }
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    performSegue(withIdentifier: "toCandidatesIndexVC", sender: indexPath)
//  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

