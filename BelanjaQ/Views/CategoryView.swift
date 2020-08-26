//
//  CategoryView.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        
        collectionView.delegate = self
        
        let nibFilter = UINib(nibName: "CategoryViewCell", bundle: nil)
        self.collectionView.register(nibFilter, forCellWithReuseIdentifier: "CategoryViewCell")
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

extension CategoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        let newSize = CGSize(width: width, height: 80)
        return newSize
    }
}
