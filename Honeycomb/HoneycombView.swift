//
//  HoneycombView.swift
//  Honeycomb
//
//  Created by Daniel Hammond on 9/27/14.
//  Copyright (c) 2014 Sparks Labs. All rights reserved.
//

import UIKit

class HoneycombView: UICollectionView {
    required override init() {
        return super.init(frame: CGRectZero, collectionViewLayout: HoneycombLayout())
    }

    required init(coder aDecoder: NSCoder) {
        return super.init(coder: aDecoder)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
