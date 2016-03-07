//
//  GDDrawingView.swift
//  DrawingBoard
//
//  Created by Geeven on 16/3/6.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit

class GDDrawingView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 私有变量
    /// 图片
    var image:UIImage?{
        
        didSet {
            let path:GDBezierPath = GDBezierPath()
            
            path.image = image
            //将路径加入到数组
            pathes.append(path)
            //3.重绘
            setNeedsDisplay()
        }
    }
    /// 线宽
    var lineWidth:CGFloat?
    /// 线条色
    var lineColor:UIColor?
    /// 背景色
    var backColor:UIColor?
    /// 路径数组
    private lazy var pathes:[GDBezierPath] = [GDBezierPath]()
    
    
    override func drawRect(rect: CGRect) {
        
        for path in pathes {
            
            if path.image != nil {
                path.image?.drawInRect(rect)
                
            }else {
                
                //TODO:
                //                path.lineColor?.set()
                UIColor.redColor().set()
                
                path.stroke()
            }
        }
    }
}

extension GDDrawingView {
    
    /// 回退
    func undo(){
        print("\(__FUNCTION__)")
        if pathes.count != 0 {
            pathes.removeLast()
            setNeedsDisplay()
        }
    }
    /// 橡皮擦
    func erase() {
        print("\(__FUNCTION__)")
        lineColor = backgroundColor
    }
    /// 清屏
    func clearnScreen() {
        print("\(__FUNCTION__)")
        
        pathes.removeAll()
        setNeedsDisplay()
    }
    /// 保存图片至相册
    func saveDrawing() {
        
        //1.打开当前图形上下文
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.mainScreen().scale)
        //2.获取当前上下文
        let ctx:CGContextRef = UIGraphicsGetCurrentContext()!
        //3.把当前的view渲染到上下文中
        layer.renderInContext(ctx)
        //4.从上下文中获取照片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //5.关闭当前上下文
        UIGraphicsEndImageContext()
        //6.将图片保存到当前相册中
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
}

// MARK: - TouchesEvent
extension GDDrawingView {
    
    /// 返回手指按压点
    ///
    /// - parameter touches: touches
    ///
    /// - returns: 当前手指按着的点
    private func pointWithTouches(touches:Set<UITouch>)-> CGPoint {
        let touch = touches.first
        return (touch?.locationInView(touch?.view))!
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //1.当前的触摸点
        let cPoint = pointWithTouches(touches)
        
        //2.一个GDBezierPath对象
        let path = GDBezierPath()
        path.moveToPoint(cPoint)
        
        //3.设置该对象的属性
        //path.lineWidth = lineWidth!
        //path.lineColor = lineColor
        
        //4.将该对象加入到数组中
        pathes.append(path)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //1.取得当前点
        let cPoint = pointWithTouches(touches)
        
        //2.将刚接触的点取出，并绘制线
        let path = pathes.last
        path?.addLineToPoint(cPoint)
        setNeedsDisplay()
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(pathes.count)
    }
}

