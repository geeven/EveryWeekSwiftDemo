//
//  ViewController.swift
//  Demo2
//
//  Created by Geeven on 16/3/4.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setGesture()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -Event Mothed
    @objc private func panGesture(panGesture:UIPanGestureRecognizer) {
        
        let location = panGesture.locationInView(containerView)
        
        containerView.transform = CGAffineTransformTranslate(containerView.transform, location.x, 0)
        
    }
    
    
    //MARK: - 私有控件
    /// 容器视图
    private lazy var containerView:UIView = {
        
        let tmpView = UIView(frame: self.view.bounds)
        tmpView.backgroundColor = UIColor.blueColor()
        
        return tmpView
        
    }()
    ///  子控制器tableViewController
    private lazy var tableViewVC:UITableViewController = UITableViewController(style: .Plain)
}

extension ViewController {
    
    /// 设置UI
    private func setupUI() {
        //1.设置背景
        view.backgroundColor = UIColor.yellowColor()
        //2.添加－>保证响应链的正确传递
        view.addSubview(containerView)
        self.addChildViewController(tableViewVC)
        containerView.addSubview(tableViewVC.view)
        
        tableViewVC.view.frame = view.bounds
        
    }
    
    private func setGesture() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "panGesture:")
        view.addGestureRecognizer(panGesture)
        
    }
    
}

