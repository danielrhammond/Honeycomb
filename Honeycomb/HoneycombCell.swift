//
//  HoneycombCell.swift
//  Honeycomb
//
//  Created by Daniel Hammond on 9/27/14.
//  Copyright (c) 2014 Sparks Labs. All rights reserved.
//

import UIKit

class HoneycombCell: UICollectionViewCell {
    var label:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(label)
    }
    override init() {
        super.init()
        label.textAlignment = .Center
        self.contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let sideLength = fmin(CGRectGetWidth(contentView.bounds), CGRectGetHeight(contentView.bounds))
        label.layer.cornerRadius = sideLength / 2.0
        label.layer.masksToBounds = true
        label.center = contentView.center
        label.bounds = CGRect(origin: CGPointZero, size: CGSize(width: sideLength, height: sideLength))
    }

    required init(coder aDecoder: NSCoder) {
        label = UILabel()
        return super.init(coder: aDecoder)
    }    
}
