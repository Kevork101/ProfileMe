//
//  CompanyListViewController.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import UIKit

class CompanyListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var companies: Companies!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companies = Companies()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        companies.loadData {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! CompanyDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.company = companies.companyArray[selectedIndexPath.row]
        }
    }

}

extension CompanyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.companyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CompanyTableViewCell
        cell.companyLabel?.text = companies.companyArray[indexPath.row].name
        cell.addressLabel?.text = companies.companyArray[indexPath.row].address
        cell.statusLabel?.text = companies.companyArray[indexPath.row].status
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
