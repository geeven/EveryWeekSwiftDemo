//
//  ViewController.swift
//  Demo1
//
//  Created by Geeven on 16/3/3.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - 属性
    @IBOutlet weak var containerView: UIView!
    
    
    //MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        //添加手势
        let gesture = UIPanGestureRecognizer(target: self, action:"panGesture:")
        
        view.addGestureRecognizer(gesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - 私有函数
    @objc private func panGesture(gesture:UIPanGestureRecognizer) {
        
        let location = gesture.locationInView(self.containerView)
        
        containerView.transform = CGAffineTransformTranslate(containerView.transform, location.x, 0)
        
        gesture.setTranslation(CGPointZero, inView: containerView)
        
    }
    
    //MARK: - 私有函数
    private lazy var titleLabel:UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(20)
        label.text = "利用storyBoard实现\n最简单的抽屉效果"
        label.textColor = UIColor.redColor()
        label.backgroundColor = UIColor.yellowColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        label.sizeToFit()
        
        return label
    }()
    
    
}

extension ViewController {
    
    private func setupUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
        }
        
    }
    
}
