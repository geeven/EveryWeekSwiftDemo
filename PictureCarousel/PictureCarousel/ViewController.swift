//
//  ViewController.swift
//  PictureCarousel
//
//  Created by Geeven on 16/3/6.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit


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
}

// MARK: - 设置UI界面
extension ViewController {
    
    private func prepareForUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        LoopView = GDLoopView(urls: urls, didSelectedCallBack: { (index) -> () in
            //
            print("选中了第\(index)个")
        })
        
        view.addSubview(LoopView!)
        
        LoopView!.frame = CGRect(x: 0, y: 20, width: view.bounds.size.width, height: 200)
        
        LoopView!.backgroundColor = UIColor.redColor()
        
    }
   
}

