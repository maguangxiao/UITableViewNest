//
//  GXInnerTableView.swift
//  newTableViewTest
//
//  Created by GuangXiao on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class GXInnerTableView: UITableView,UIGestureRecognizerDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
