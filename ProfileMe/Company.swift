//
//  Company.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import Foundation
import Firebase

class Company {
    var name: String
    var website: String
    var address: String
    var status: String
    var description: String
    var EBITDA: Int
    var EVToRevenue: Double
    var EVToEBITDA: Double
    //var iconImageURL: URL
    var postingUserID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["name": name, "website": website, "status": status, "address": address, "description":description, "EBITDA": EBITDA, "EVToRevenue":EVToRevenue, "EVToEBITDA": EVToEBITDA, "postinguserID": postingUserID]
        //return ["name": name, "website": website, "address": address, "iconImageURL": iconImageURL, "postinguserID": postingUserID]
    }
    
        init(name: String, website: String, address: String, description: String, EBITDA: Int, EVToRevenue: Double, EVToEBITDA: Double, status: String, postingUserID: String, documentID: String) {
        self.name = name
        self.website = website
        self.address = address
        self.status = status
        self.description = description
        self.EBITDA = EBITDA
        self.EVToRevenue = EVToRevenue
        self.EVToEBITDA = EVToEBITDA
        //self.iconImageURL = iconImageURL
        self.postingUserID = postingUserID
        self.documentID = documentID
        
    }
    
    convenience init() {
        self.init(name: "", website: "", address: "", description: "", EBITDA: 0, EVToRevenue: 0, EVToEBITDA: 0.0, status: "", postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let website = dictionary["website"] as! String? ?? ""
        let address = dictionary["address"] as! String? ?? ""
        //let iconImageURL = dictionary["iconImageURL"] as! URL? ?? ""
        let description = dictionary["description"] as! String? ?? ""
        let EBITDA = dictionary["EBITDA"] as! Int? ?? 0
            let EVToRevenue = dictionary["EVToRevenue"] as! Double? ?? 0.0
            let EVToEBITDA = dictionary["EVToEBITDA"] as! Double? ?? 0.0
        let status = dictionary["status"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(name: name, website: website, address: address, description: description, EBITDA: EBITDA, EVToRevenue: EVToRevenue, EVToEBITDA: EVToEBITDA, status: status, postingUserID: postingUserID, documentID: "")
    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        //Grab the user ID
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("Could not save data")
            return completion(false)
        }
        
        self.postingUserID = postingUserID
        //Create dictionary representing data we want to save
        let dataToSave: [String:Any] = self.dictionary
        if self.documentID == "" {
            var ref: DocumentReference? = nil
            ref = db.collection("companies").addDocument(data: dataToSave) { (error) in guard error == nil else {
                print("\(error!.localizedDescription)")
                return completion(false)
            }
                self.documentID = ref!.documentID
                print("Added document: \(self.documentID)")
                completion(true)
            }
        }else { //else save here
            let ref = db.collection("companies").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("\(error!.localizedDescription)")
                    return completion(false)
                }
                print("Updated document: \(self.documentID)")
                completion(true)
            }
        }
    }
}
