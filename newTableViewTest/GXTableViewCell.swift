//
//  GXTableViewCell.swift
//  newTableViewTest
//
//  Created by GuangXiao on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class GXTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    
    var cellWillBeDisplayed:((offset:CGFloat)->())?

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib(nibName: "GXCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "anotherId")
        
        collectionView.pagingEnabled = true
        
        collectionView.bounces = false
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("anotherId", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor(red: CGFloat(arc4random() % 256) / 255, green: CGFloat(arc4random() % 256) / 255, blue: CGFloat(arc4random() % 256) / 255, alpha: 1)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
//        print("显示第\(indexPath.row)个")
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
        cellWillBeDisplayed?(offset:scrollView.contentOffset.x)
    }
    
    
}
