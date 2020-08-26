//
//  DetailProductViewModel.swift
//  BelanjaQ
//
//  Created by RenhardJH on 26/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import RealmSwift

public final class DetailProductViewModel {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func saveProductHistory() {
        let history = ProductPurchased()
        history.id = product.id
        history.imageUrl = product.imageUrl
        history.title = product.title
        history.desc = product.description
        history.loved = product.loved
        history.price = product.price
        
        let formatter           = DateFormatter()
        formatter.dateFormat    = "dd MMM yyyy HH:mm"
        history.date = formatter.string(from: Date())
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(history)
        }
    }
}
