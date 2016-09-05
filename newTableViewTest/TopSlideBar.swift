//
//  TopSlideBar.swift
//  slideBar
//
//  Created by GuangXiao on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.mainScreen().bounds.size.width

let defineYellowColor = UIColor.yellowColor()

let defineBlackColor = UIColor.blackColor()

class TopSlideBar: UIView,UIScrollViewDelegate {

    var itemTitleArray:[String]?
    var selectedItem:UIButton!
    var bgView:UIView!
    var slideView:UIView!

    var items:[UIButton] = [UIButton]()
        /// 选中某一个item之后执行的闭包
    var selectedItemWithTagClosure:((tag:Int)->())?
    
    convenience init(itemTitles:[String],frame:CGRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 40)) {
        self.init()
        itemTitleArray = itemTitles
        
        self.frame = frame
        
        setupBgView()
        setupSlideView(itemTitles)
        setupContentView(itemTitles)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    func setupBgView(){
        
        self.bgView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        
        bgView.backgroundColor = UIColor.whiteColor()
        self.addSubview(bgView)
        
    }
    
    func setupSlideView(itemTitles:[String]){
        
        let slideView = UIView(frame: CGRectMake(0, bgView!.frame.size.height - 1, UIScreen.mainScreen().bounds.width / CGFloat(itemTitles.count), 1.5))
        slideView.layer.cornerRadius = 1
        slideView.layer.masksToBounds = true
        slideView.backgroundColor = defineYellowColor
        self.slideView = slideView
        bgView?.addSubview(self.slideView)
    }
    
    func setupContentView(itemTitles:[String]){
        
        for i in 0..<itemTitles.count{
            
            let itemW = bgView.frame.size.width / CGFloat(itemTitles.count)
            let itemH = bgView.frame.size.height - 1
            let itemX = itemW * CGFloat(i)
            let itemY:CGFloat = 0
            
            let item = UIButton(frame:CGRectMake(itemX, itemY, itemW, itemH))
            
            item.addTarget(self, action: #selector(TopSlideBar.buttonClick(_:)), forControlEvents: .TouchUpInside)

            item.setTitle(itemTitles[i], forState: .Normal)
            item.titleLabel?.font = UIFont.systemFontOfSize(14)
            
            item.setTitleColor(defineBlackColor, forState: .Normal)
            item.tag = 1200 + i
            
            bgView.addSubview(item)
            if i == 0{
                item.setTitleColor(defineYellowColor, forState: .Normal)
                selectedItem = item
            }
        }
    }
    
    //选中哪一个
    func selectItemWithTag(tag:Int){
        let item = viewWithTag(tag) as! UIButton
        if item == selectedItem{
            return
        }
        selectedItem.setTitleColor(defineBlackColor, forState: .Normal)
        item.setTitleColor(defineYellowColor, forState: .Normal)
        
//        addAnimationWithSelectedItem(item)
        selectedItem = item
        
    }
    
    @objc private func buttonClick(sender:UIButton){
        if sender.tag == selectedItem.tag{//如果点击的是之前选中的item就不再做任何操作
            return
        }
        
        selectedItem.setTitleColor(defineBlackColor, forState: .Normal)
        sender.setTitleColor(defineYellowColor, forState: .Normal)
        
        addAnimationWithSelectedItem(sender)
        
        selectedItem = sender
        selectedItemWithTagClosure!(tag:sender.tag)
    }
    
    //添加移动动画
    func addAnimationWithSelectedItem(item:UIButton){
        
        let distanceX = CGRectGetMinX(item.frame) - CGRectGetMaxX(selectedItem.frame)
        
        //添加基本动画
//        let positionAnimation = CABasicAnimation()
//        positionAnimation.keyPath = "position.x"
//        positionAnimation.fromValue = slideView.layer.position.x
//        positionAnimation.toValue = slideView.layer.position.x + distanceX
//        
//        slideView.layer.addAnimation(positionAnimation, forKey: "basic")
        slideView.layer.position = CGPointMake(slideView.layer.position.x + distanceX, slideView.layer.position.y)
    
        slideView.frame = CGRectMake(CGRectGetMinX(item.frame), bgView.frame.size.height - 1, bgView.frame.size.width/CGFloat(itemTitleArray?.count ?? 0), 1)
    }
    
    func scrollSmothly(offset:CGFloat){
        
        let mayBeTag:CGFloat = offset/ScreenWidth
        
        if [0.0,1.0,2.0,3.0,4.0,5.0,6.0].contains(mayBeTag){
            selectedItem.setTitleColor(defineBlackColor, forState: .Normal)
            let aa = viewWithTag(1200 + Int(mayBeTag)) as! UIButton
            aa.setTitleColor(defineYellowColor, forState: .Normal)
            selectedItem = aa
        }
        
//        switch mayBeTag {
//        case 1.0:
//            selectedItem.setTitleColor(defineBlackColor, forState: .Normal)
//            let aa = viewWithTag(1200 + 1) as! UIButton
//            aa.setTitleColor(defineYellowColor, forState: .Normal)
//            selectedItem = aa
//            break
//            
//        case 2.0:
//            selectedItem.setTitleColor(defineBlackColor, forState: .Normal)
//
//            let aa = viewWithTag(1200 + 2) as! UIButton
//            aa.setTitleColor(defineYellowColor, forState: .Normal)
//            selectedItem = aa
//            
//            break
//        case 0.0:
//            selectedItem.setTitleColor(defineBlackColor, forState: .Normal)
//
//            let aa = viewWithTag(1200 + 0) as! UIButton
//            aa.setTitleColor(defineYellowColor, forState: .Normal)
//            selectedItem = aa
//            break
//            
//        case 3.0:
//            selectedItem.setTitleColor(defineBlackColor, forState: .Normal)
//            
//            let aa = viewWithTag(1200 + 3) as! UIButton
//            aa.setTitleColor(defineYellowColor, forState: .Normal)
//            selectedItem = aa
//            break
//            
//        default:
//            break
//        }
        
        let propertion = offset / (ScreenWidth * CGFloat(itemTitleArray?.count ?? 1))
        slideView.layer.position = CGPointMake(ScreenWidth * propertion, slideView.layer.position.y)
        
        slideView.frame = CGRectMake(ScreenWidth * propertion, bgView.frame.size.height - 1, bgView.frame.size.width/CGFloat(itemTitleArray?.count ?? 0), 1)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
