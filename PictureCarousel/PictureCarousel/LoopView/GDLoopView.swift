//
//  GDLoopView.swift
//  PictureCarousel
//
//  Created by Geeven on 16/3/6.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit

private let GDLoopViewCellReuseIndetifier = "GDLoopViewCellReuseIndetifier"

class GDLoopView: UICollectionView {
    
    let didSelectedCallBaCk:(index:NSInteger) -> ()
    
    //MARK: - 生命周期方法
    init(urls:[NSURL],didSelectedCallBack:(index:NSInteger)->()) {
        
        dataArr = urls
        
        didSelectedCallBaCk = didSelectedCallBack
        
        
        super.init(frame: CGRectZero, collectionViewLayout: GDLoopViewLayout())
        
        dataSource = self
        delegate = self
        
        registerClass(GDLoopViewCell.self, forCellWithReuseIdentifier: GDLoopViewCellReuseIndetifier)
        
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if self.dataArr.count > 1 {
                
                let indexPath = NSIndexPath(forItem: self.dataArr.count, inSection: 0)
                self.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
                self.index = indexPath.item
                
                self.addTimer()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MRK:私有属性
    private var dataArr:[NSURL]
    
    var timer:NSTimer?
    
    var index:NSInteger = 0
}

// MARK: - 设置定时器及相关事件`
extension GDLoopView {
    
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "next", userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        
    }
    
    @objc private func next() {
        
        if index == NSInteger(numberOfItemsInSection(0)-1) {
            
            index = 0
        } else {
            
            index++
        }
        
        setContentOffset(CGPointMake(CGFloat(index) * bounds.width, 0), animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        addTimer()
    }
    
}

// MARK: - UICollectionViewDataSource,UICollectionViewDelegate
extension GDLoopView:UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArr.count * (dataArr.count == 1 ? 1 : 20)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(GDLoopViewCellReuseIndetifier, forIndexPath: indexPath) as! GDLoopViewCell
        
        cell.url = dataArr[indexPath.item % self.dataArr.count]
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var pageNo = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        //判断是第一页还是最后一页
        if(pageNo == (numberOfItemsInSection(0) - 1)) || (pageNo == 1) {
            pageNo = self.dataArr.count - (pageNo == 0 ? 0 : 1)
            
            scrollView.contentOffset = CGPointMake(CGFloat(pageNo) * scrollView.bounds.width, 0)
        }
        index = NSInteger(pageNo)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        didSelectedCallBaCk(index: indexPath.item % self.dataArr.count)
        index = indexPath.item
    }
}

