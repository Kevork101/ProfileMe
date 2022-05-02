//
//  CompanyDetails.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import Foundation

class CompanyDetails {

struct Returned: Codable {
    var Symbol: String
    var Name: String
    var Description: String
    var Address: String
    var EBITDA: String
    var EVToRevenue: String
    var EVToEBITDA: String
}

    var ticker = "" //CompanyDetailViewController.tickerTextField.text
    var key = APIKeys.alphaVantageKey
    var Symbol = ""
    var Name = ""
    var Description = ""
    var Address = ""
    var EBITDA = ""
    var EVToRevenue = ""
    var EVToEBITDA = ""


func getData(completed: @escaping() -> ()) {
    var function = "OVERVIEW"
    //let urlString = "https://www.alphavantage.co/query?function=\(function)&symbol=\(ticker)&apikey=\(key)"
    let urlString = "https://www.alphavantage.co/query?function=\(function)&symbol=\(ticker)&apikey=\(key)"
    print(urlString)
    
    //create url
    guard let url = URL(string: urlString) else {
        print("ERROR: from \(urlString)")
        completed()
        return
    }
    
    //Create session
    let session = URLSession.shared
    
    //get data with .dataTask
    let task = session.dataTask(with: url) { data, response, error in
        if let error = error {
            print("ERROR: \(error.localizedDescription)")
        }
        
        do {
            let returned = try JSONDecoder().decode(Returned.self, from: data!)
            self.Symbol = returned.Symbol
            self.Name = returned.Name
            self.Description = returned.Description
            self.Address = returned.Address
            self.EBITDA = returned.EBITDA
            self.EVToRevenue = returned.EVToRevenue
            self.EVToEBITDA = returned.EVToEBITDA
        } catch {
            print("JSON ERROR: \(error.localizedDescription)")
        }
        completed()
    }
    
    task.resume()
}

/*
func getCompanyFinancialDatas(function: String = "INCOME_STATEMENT", ticker: String = "test", key: String = APIKeys.alphaVantageKey) {
    let url = URL(string: "https://www.alphavantage.co/query?function=\(function)&symbol=\(ticker)&apikey=\(key)")!
    //url = 'https://www.alphavantage.co/query?function=INCOME_STATEMENT&symbol=IBM&apikey=demo'
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200,
              error == nil else {
                  // ERROR
                  return
              }
        do {
            //JSON DECODER
            print("go?")
            let returned = try JSONDecoder().decode(Returned.self, from: data)
            print(returned.EBITDA)
            //print(returned)
            //print(returned.annualReports.first?.ebitda)
        } catch {
            print("ERROR occuring")
        }

    }
    .resume()
}


func getCompanyFinancialDatas(function: String = "INCOME_STATEMENT", ticker: String = "test", key: String = APIKeys.alphaVantageKey) {

    //create url
    guard let urlString = URL(string: "https://www.alphavantage.co/query?function=\(function)&symbol=\(ticker)&apikey=\(key)")! else {
        print("ERROR")
        completed()
        return
    }
    
    //Create session
    let session = URLSession.shared
    
    //get data with .dataTask
    let task = session.dataTask(with: url) { data, response, error in
        if let error = error {
            print("ERROR: \(error.localizedDescription)")
        }
        
        do {
            let returned = try JSONDecoder().decode(Returned.self, from: data!)
            self.numberOfSpecies = returned.count
            self.urlString = returned.next ?? ""
            self.speciesArray = self.speciesArray + returned.results
        } catch {
            print("JSON ERROR: \(error.localizedDescription)")
        }
        self.isFetching = false
        completed()
    }
    
    task.resume()
}
  */

}
