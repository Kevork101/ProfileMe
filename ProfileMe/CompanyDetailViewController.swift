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
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var EBITDATextField: UITextField!
    @IBOutlet weak var EVRevTextField: UITextField!
    @IBOutlet weak var EVEbitdaTextField: UITextField!
    @IBOutlet weak var EVTextField: UITextField!
    
    @IBOutlet weak var tickerTextField: UITextField!
    
    //@IBOutlet weak var companyImageView: UIImageView!
    
    var company: Company!
    var companyDetails = CompanyDetails()
    
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
        descriptionTextView.text = String(company.description)
        //EBITDATextField.text = "\(company.EBITDA)x"
        EBITDATextField.text = "$\(company.EBITDA)" //String(format: "$%.2f", company.EBITDA)
        EVRevTextField.text = "\(company.EVToRevenue)x"
        EVEbitdaTextField.text = "\(company.EVToEBITDA)x"
        EVTextField.text = "$\(Double(company.EVToEBITDA) * Double(company.EBITDA))"
    }
    
    func updateTerms() {
        
        company.name = companyDetails.Name
        company.address = companyDetails.Address
        company.description = companyDetails.Description
        //print(companyDetails.Description)
        company.EBITDA = Double(companyDetails.EBITDA) ?? 0.0
        company.EVToRevenue = Double(companyDetails.EVToRevenue) ?? 0.0
        company.EVToEBITDA = Double(companyDetails.EVToEBITDA) ?? 0.0
        
//        companyTextField.text = companyDetails.Name
//        addressTextField.text = companyDetails.Address
//        descriptionTextField.text = companyDetails.Description
//        EBITDATextField.text = companyDetails.EBITDA
//        EVRevTextField.text = companyDetails.EVToRevenue
//        EVEbitdaTextField.text = companyDetails.EVToEBITDA
    }
    
    func updateFromInterface() {
        company.name = companyTextField.text!
        company.address = addressTextField.text!
        company.status = statusTextField.text!
        company.description = descriptionTextView.text!
        company.EBITDA = Double(EBITDATextField.text!) ?? 0.0
        company.EVToRevenue = Double(EVRevTextField.text!) ?? 0.0
        company.EVToEBITDA = Double(EVEbitdaTextField.text!) ?? 0.0
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
    
    @IBAction func populateButtonPressed(_ sender: Any) {
        companyDetails.ticker = tickerTextField.text! 
        companyDetails.getData {
            DispatchQueue.main.async {
                self.updateTerms()
                self.updateUserInterface()
            }
        }
        updateUserInterface()
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
