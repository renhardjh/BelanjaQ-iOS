//
//  SearchViewModel.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public final class SearchViewModel {
    private var typingTimer: Timer!
    var productList: [Product]
    var productResults: [Product]!
    var product = BehaviorRelay<[Product]>(value: [])
    
    init(products: [Product]) {
        self.productList = products
    }
    
    func searchProducts(keyword: String) {
        if typingTimer != nil {
            typingTimer.invalidate()
        }
        typingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.productResults = self.productList.filter { $0.title.lowercased().contains(keyword.lowercased()) }
            self.product.accept(self.productResults)
        }
    }
}
