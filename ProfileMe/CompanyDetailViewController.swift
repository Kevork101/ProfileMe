//
//  CompanyDetailViewController.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import UIKit
import GooglePlaces

class CompanyDetailViewController: UIViewController {
    
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var companyImageView: UIImageView!
    
    var company: Company!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if company == nil {
            company = Company()
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        companyTextField.text = company.name
        addressTextField.text = company.address
        statusTextField.text = company.status
        getCompanyFinancialData(function: "INCOME_STATEMENT", ticker: "AMZN", key: APIKeys.alphaVantageKey)
        
    }
    
    func updateFromInterface() {
        company.name = companyTextField.text!
        company.address = addressTextField.text!
        company.status = statusTextField.text!
        //companyImageView.image = UIImage(named: company.icon)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromInterface()
        company.saveData { (success) in
            if success {
                self.leaveViewController()
            }else{
                self.oneButtonAlert(title: "Save Failed", message: "Error occured during save")
                //print("Error occured during save")
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    
}

extension CompanyDetailViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    company.name = place.name ?? "Unknown Place"
    company.address = place.formattedAddress ?? "Unknown Address"
    //company.website = place.website ?? "Unknown Website"
    //company.iconImageURL = place.iconImageURL ?? nil
    
    updateUserInterface()
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

}
