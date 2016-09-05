//
//  GXCollectionViewCell.swift
//  newTableViewTest
//
//  Created by GuangXiao on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit


class GXCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {

    var shouldScroll:Bool = false
    
    @IBOutlet weak var innerTableView: GXInnerTableView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GXCollectionViewCell.changeScrollEnable(_:)), name: goTopNotificationName, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GXCollectionViewCell.changeScrollEnable(_:)), name: leaveTopNotificationName, object: nil)
        
        innerTableView.registerNib(UINib(nibName: "GXInnerTableViewCell",bundle: nil), forCellReuseIdentifier: "GXInnerTableViewCell")
        
    }
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        
//        return true
//        
//    }
    
    @objc private func changeScrollEnable(notification:NSNotification){
        
        
        let nameStr = notification.name
        
        if nameStr == goTopNotificationName{
            
                innerTableView.showsVerticalScrollIndicator = true
                
                shouldScroll = true
                
            
        }else if nameStr == leaveTopNotificationName{
            
            innerTableView.contentOffset = CGPointZero
            
            shouldScroll = false
            
            innerTableView.showsVerticalScrollIndicator = false
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("GXInnerTableViewCell", forIndexPath: indexPath)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 120
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        if !shouldScroll {
            
            scrollView.setContentOffset(CGPointZero, animated: false)
            
        }
        
        
        if scrollView.contentOffset.y <= 0{
            
            NSNotificationCenter.defaultCenter().postNotificationName(leaveTopNotificationName, object: nil)
            
        }
    }
   
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
//    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
//        if !canScroll{
//            return false
//        }
//        return super.pointInside(point, withEvent: event)
//    }
    
}
