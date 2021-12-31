//
//  BreedsListResponse.swift
//  doggo
//
//  Created by Jameka Echols on 12/30/21.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
