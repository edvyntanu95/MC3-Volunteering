//
//  StretchyHeader.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 23/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class StretchyHeader: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: CGRectEdge) as [UICollectionViewLayoutAttributes]
        let
        
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
