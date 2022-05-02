//
//  Companies.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import Foundation
import Firebase

class Companies {
    var companyArray: [Company] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("companies").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("ERROR: adding snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.companyArray = []
            for document in querySnapshot!.documents {
                //pass in dictionary
                let company = Company(dictionary: document.data())
                company.documentID = document.documentID
                self.companyArray.append(company)
                }
            completed()
        }
    }
}
