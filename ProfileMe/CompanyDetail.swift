//
//  CompanyDetail.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import Foundation

struct Returned: Codable {
    var symbol: String
    var annualReports: [AnnualReport]
}

struct AnnualReport: Codable {
    var fiscalDateEnding: String
    var ebitda: String
}

func getCompanyFinancialData(function: String = "INCOME_STATEMENT", ticker: String = "test", key: String = "") {
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
            let returned = try JSONDecoder().decode(Returned.self, from: data)
            //print(returned.annualReports.first?.ebitda)
        } catch {
            // ERROR
        }
    }.resume()
}
