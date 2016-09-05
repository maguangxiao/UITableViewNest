//
//  GXFlowLayout.swift
//  newTableViewTest
//
//  Created by GuangXiao on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class GXFlowLayout: UICollectionViewFlowLayout {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doSomeThing()
    }
    
    override init() {
        super.init()
        doSomeThing()
    }
    
    func doSomeThing() {
        itemSize = CGSizeMake(ScreenWidth, UIScreen.mainScreen().bounds.size.height - 64 - 45)
        
        print(itemSize)
        
        minimumInteritemSpacing = 0
        
        minimumLineSpacing = 0
        
        scrollDirection = .Horizontal
        
        
    }
    
}
