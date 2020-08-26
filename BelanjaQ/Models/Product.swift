//
//  Product.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let id: String
    let title: String
    let description: String
    let price: String
    var loved: Int
    let imageUrl: String
}
