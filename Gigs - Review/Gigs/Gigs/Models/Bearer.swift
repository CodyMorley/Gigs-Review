//
//  Bearer.swift
//  Gigs
//
//  Created by Cody Morley on 8/5/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

struct Bearer: Codable {
    let id: Int
    let token: String
    let userID: Int
}
