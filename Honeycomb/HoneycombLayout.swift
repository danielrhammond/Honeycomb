//
//  HoneycombLayout.swift
//  Honeycomb
//
//  Created by Daniel Hammond on 9/27/14.
//  Copyright (c) 2014 Sparks Labs. All rights reserved.
//

import UIKit

let edgeLength:CGFloat = 20.0

class HoneycombLayout: UICollectionViewLayout {
    let nodeHeight:CGFloat = 2.0 * edgeLength
    let nodeWidth:CGFloat = sqrt(3) * edgeLength
    var centers:[CGPoint] = []
    var indexPaths:[NSIndexPath] = [ NSIndexPath(forItem: 0, inSection: 0) ]
    
    override func prepareLayout() {
        super.prepareLayout();
        var currentRing = 1
        let count = collectionView?.numberOfItemsInSection(0)
        while indexPaths.count < count {
            let ring = hexagonalRing(NSIndexPath(forItem: 0, inSection: 0), n: currentRing)
            for indexPath in ring {
                if indexPaths.count < count {
                    indexPaths.append(indexPath)
                }
            }
            currentRing += 1
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes:[UICollectionViewLayoutAttributes] = []
        for (index,indexPath) in enumerate(indexPaths) {
            let center = centerForIndexPath(indexPath)
            if true || CGRectContainsPoint(rect, center) {
                var cell = UICollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: index, inSection: 0))
                cell.center = center
                cell.bounds = CGRect(origin: CGPointZero, size: CGSize(width: nodeWidth, height: nodeHeight))
                attributes.append(cell)
            }
        };
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let center = centerForIndexPath(indexPath)
        var cell = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        cell.center = center
        cell.bounds = CGRect(origin: CGPointZero, size: CGSize(width: nodeWidth, height: nodeHeight))
        return cell
    }
    
    func neighboringIndexPaths(indexPath:NSIndexPath) -> [NSIndexPath] {
        return [
            NSIndexPath(forItem: indexPath.row,   inSection: indexPath.section-1),
            NSIndexPath(forItem: indexPath.row+1, inSection: indexPath.section-1),
            NSIndexPath(forItem: indexPath.row-1, inSection: indexPath.section),
            NSIndexPath(forItem: indexPath.row+1, inSection: indexPath.section),
            NSIndexPath(forItem: indexPath.row-1, inSection: indexPath.section+1),
            NSIndexPath(forItem: indexPath.row,   inSection: indexPath.section+1),
        ]
    }
    
    func centerForIndexPath(indexPath:NSIndexPath) -> CGPoint {
        let q:CGFloat = CGFloat(indexPath.section)
        let r:CGFloat = CGFloat(indexPath.row)
        let center = CGPoint(x: edgeLength * sqrt(3) * (q + (r/2.0)), y: edgeLength * 3.0/2.0 * r)
        let collectionViewCenter = collectionView!.center
        return CGPoint(x: collectionViewCenter.x + center.x, y: collectionViewCenter.y + center.y)
    }

    func hexagonalRing(indexPath:NSIndexPath, n:Int) -> [NSIndexPath] {
        func northEastNeighbor(indexPath:NSIndexPath) -> NSIndexPath {
            return NSIndexPath(forItem: indexPath.item - 1, inSection: indexPath.section + 1)
        }
        func northWestNeighbor(indexPath:NSIndexPath) -> NSIndexPath {
            return NSIndexPath(forItem: indexPath.item - 1, inSection: indexPath.section)
        }
        func westNeighbor(indexPath:NSIndexPath) -> NSIndexPath {
            return NSIndexPath(forItem: indexPath.item, inSection: indexPath.section - 1)
        }
        func eastNeighbor(indexPath:NSIndexPath) -> NSIndexPath {
            return NSIndexPath(forItem: indexPath.item, inSection: indexPath.section + 1)
        }
        func southWestNeighbor(indexPath:NSIndexPath) -> NSIndexPath {
            return NSIndexPath(forItem: indexPath.item + 1, inSection: indexPath.section - 1)
        }
        func southEastNeighbor(indexPath:NSIndexPath) -> NSIndexPath {
            return NSIndexPath(forItem: indexPath.item + 1, inSection: indexPath.section)
        }
        
        var results:[NSIndexPath] = []
        var current = indexPath
        for _ in 1...n {
            current = northEastNeighbor(current)
        }
        for i in 0..<n {
            results.append(current)
            current = southEastNeighbor(current)
        }
        for i in 0..<n {
            results.append(current)
            current = southWestNeighbor(current)
        }
        for i in 0..<n {
            results.append(current)
            current = westNeighbor(current)
        }
        for i in 0..<n {
            results.append(current)
            current = northWestNeighbor(current)
        }
        for i in 0..<n {
            results.append(current)
            current = northEastNeighbor(current)
        }
        for i in 0..<n {
            results.append(current)
            current = eastNeighbor(current)
        }
        return results
    }
}
