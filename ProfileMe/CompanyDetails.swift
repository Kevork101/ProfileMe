//
//  CompanyDetails.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import Foundation

struct Result: Codable {
    var symbol: String
    var name: String
    var description: String
    var address: String
    var EBITDA: Int
    var EVToRevenue: Double
    var EVToEBITDA: Double
}
