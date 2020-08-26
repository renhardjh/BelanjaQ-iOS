//
//  PurchaseHistoryViewModel.swift
//  BelanjaQ
//
//  Created by RenhardJH on 26/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

public final class PurchaseHistoryViewModel {
    var productPurchasedList: [ProductPurchased]!
    var history = BehaviorRelay<[ProductPurchased]>(value: [])
    
    init() {
        loadHistory()
    }
    
    func loadHistory() {
        let realm = try! Realm()
        let results = realm.objects(ProductPurchased.self)
        if results.count > 0 {
            productPurchasedList = results.map{$0}
            self.history.accept(productPurchasedList)
        }
    }
    
    func getProduct(at: Int) -> Product {
        let history = productPurchasedList[at]
        let product = Product(id: history.id,
                              title: history.title,
                              description: history.desc,
                              price: history.price,
                              loved: history.loved, imageUrl:
            history.imageUrl)
        
        return product
    }
}
