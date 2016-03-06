//
//  ViewController.swift
//  PictureCarousel
//
//  Created by Geeven on 16/3/6.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit
import SnapKit


private let imagesCount = 3
class ViewController: UIViewController {
    
    //MARK: - 生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareForUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - 懒加载
    private lazy var urls:[NSURL] = {
        var arrM = [NSURL]()
        for i in 0 ..< imagesCount {
            let url = NSBundle.mainBundle().URLForResource(String(format: "%02d.jpg", i+1), withExtension: nil)
            arrM.append(url!)
        }
        return arrM
    }()
    
    //MARK: - 私有控件
    private var LoopView:GDLoopView?
    
    private var pageControl:UIPageControl = UIPageControl()
}

// MARK: - 设置UI界面
extension ViewController {
    
    private func prepareForUI() {
        
        //1.设置背景
        view.backgroundColor = UIColor.whiteColor()
        //2.设置LoopView
        LoopView = GDLoopView(urls: urls, didSelectedCallBack: { (index) -> () in
            
            self.pageControl.currentPage = index
        })
        view.addSubview(LoopView!)
        LoopView!.frame = CGRect(x: 0, y: 20, width: view.bounds.size.width, height: 200)
        
        //3.设置pageController
        view.addSubview(pageControl)
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKey: "_pageImage")
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKey: "_currentPageImage")
        pageControl.numberOfPages = self.urls.count
        pageControl.currentPage = 0
        pageControl.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.LoopView!)
        }
  
    }
    
}

