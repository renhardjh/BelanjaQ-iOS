//
//  ProductPurchased.swift
//  BelanjaQ
//
//  Created by RenhardJH on 26/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import RealmSwift

class ProductPurchased: Object {
    @objc dynamic var id: String!
    @objc dynamic var title: String!
    @objc dynamic var desc: String!
    @objc dynamic var price: String!
    @objc dynamic var loved = 0
    @objc dynamic var imageUrl: String!
    @objc dynamic var date: String!
}
