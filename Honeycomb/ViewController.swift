//
//  ViewController.swift
//  Honeycomb
//
//  Created by Daniel Hammond on 9/27/14.
//  Copyright (c) 2014 Sparks Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let collectionView:HoneycombView = HoneycombView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.registerClass(HoneycombCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.blackColor()
        collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["collectionView": collectionView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["collectionView": collectionView]))
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: HoneycombCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.label.backgroundColor = UIColor(red: 242/255.0, green: 192/255.0, blue: 77/255.0, alpha: 1.0)
        cell.label.text = NSString(format: "%d.%d", indexPath.section, indexPath.row)
    }
}
