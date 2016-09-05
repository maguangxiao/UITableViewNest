//
//  ViewController.swift
//  newTableViewTest
//
//  Created by GuangXiao on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

let leaveTopNotificationName = "leaveTopNotificationName"

let goTopNotificationName = "goTopNotificationName"

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
     //MARK: - 实例变量
    /// tableView是否能够滚动
    var shouldScroll:Bool = true
        /// 底部的理论上是否应该滚动
    var bottomShouldScroll:Bool = true
        /// 顶部的理论上是否应该滚动
    var upperShouldScroll:Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    
    var onlyCell:GXTableViewCell!
    
    
    
     //MARK: - 控制器生命周期
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.translucent = false
        
        navigationController?.navigationBar.barTintColor = UIColor.cyanColor()
        
        self.title = "部落"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.changeScrollEnable(_:)), name: leaveTopNotificationName, object: nil)

        setupUI()
    }

    @objc private func changeScrollEnable(notification:NSNotification){
        
            shouldScroll = true
        
    }
    
    private func setupUI(){
        
        tableView.tableHeaderView = bannerCollectionView
        
        tableView.registerNib(UINib(nibName: "GXTableViewCell",bundle: nil), forCellReuseIdentifier: "reuseId")
        
        bannerCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewReuseId")
        
        tableView.showsVerticalScrollIndicator = false

        topBar.selectedItemWithTagClosure = { [weak self]index in

            self?.onlyCell.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: index - 1200,inSection:0), atScrollPosition: .Left, animated: false)
            
        }
    }
    
    
    
     //MARK: - tableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseId", forIndexPath: indexPath) as! GXTableViewCell
        
        cell.cellWillBeDisplayed = { [weak self]offset in
            
            self?.topBar.scrollSmothly(offset)
            
        }
        
        cell.backgroundColor = UIColor(red: CGFloat(arc4random() % 256) / 255, green: CGFloat(arc4random() % 256) / 255, blue: CGFloat(arc4random() % 256) / 255, alpha: 1)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        print(UIScreen.mainScreen().bounds.size.height - topBar.frame.size.height - 64)
        return UIScreen.mainScreen().bounds.size.height - topBar.frame.size.height - 64
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
        
    }
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return topBar
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        onlyCell = cell as! GXTableViewCell
        
    }
    
     //MARK: - collectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewReuseId", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor(red: CGFloat(arc4random() % 256) / 255, green: CGFloat(arc4random() % 256) / 255, blue: CGFloat(arc4random() % 256) / 255, alpha: 1)
        
        return cell
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        let standardOffsetY:CGFloat = 150
        
        let offsetY:CGFloat = scrollView.contentOffset.y
        
        bottomShouldScroll = upperShouldScroll
        
        if offsetY >= standardOffsetY{
            
            scrollView.contentOffset = CGPointMake(0, standardOffsetY)
            
            
            upperShouldScroll = true
            
        }else{
            
            upperShouldScroll = false
            
        }
        
        if upperShouldScroll != bottomShouldScroll {
            
            if !bottomShouldScroll && upperShouldScroll{
                
                NSNotificationCenter.defaultCenter().postNotificationName(goTopNotificationName, object: nil)
                
                shouldScroll = false
                
            }
            
            if bottomShouldScroll && !upperShouldScroll{
                
                if !shouldScroll{
                    
                    scrollView.contentOffset = CGPointMake(0, standardOffsetY)
                }
            }
        }
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    lazy var bannerCollectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 150)
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.scrollDirection = .Horizontal
        
        let bannerCollectionView = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 150), collectionViewLayout: layout)
        
        bannerCollectionView.dataSource = self
        
        bannerCollectionView.delegate = self
        
        bannerCollectionView.pagingEnabled = true
        
        bannerCollectionView.showsHorizontalScrollIndicator = false
        
        bannerCollectionView.scrollsToTop = false
        
        return bannerCollectionView
        
    }()
    
    lazy var topBar:TopSlideBar = {
        
        let topBar = TopSlideBar(itemTitles: ["人物","小说","漫画"],frame: CGRectMake(0, 150, UIScreen.mainScreen().bounds.size.width, 44))
        
        return topBar
    }()
}

