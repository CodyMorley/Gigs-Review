//
//  Gig.swift
//  Gigs
//
//  Created by Cody Morley on 8/6/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation



struct Gig: Codable, Equatable {
    var title: String
    var description: String
    var dueDate: Date
}
