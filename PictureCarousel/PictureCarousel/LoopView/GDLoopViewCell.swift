//
//  GDLoopViewCell.swift
//  PictureCarousel
//
//  Created by Geeven on 16/3/6.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit

class GDLoopViewCell: UICollectionViewCell {
    
    //MARK: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 懒加载
    /// 图像视图
    private lazy var imageView:UIImageView = UIImageView(frame:self.bounds)
    
    //MARK: - 私有属性
    /// url
    var url:NSURL? {
        
        didSet {
            
            let data = NSData(contentsOfURL: url!)
            imageView.image = UIImage(data: data!)
        }
    }
    
    
}
