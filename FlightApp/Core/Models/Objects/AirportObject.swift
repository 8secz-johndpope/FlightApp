//
//  AirportObject.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public struct StationListObject: Codable {
    let stations: [AirportObject]?
}

public struct AirportObject : Codable {
    let code : String
    let name : String
    let alias: [String]
    let countryName : String
    let latitude : String
    let longitude : String
    let tripCardImageUrl: String?
    let markets: [MarketObject]
}
