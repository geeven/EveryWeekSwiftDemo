//
//  ViewController.swift
//  DrawingBoard
//
//  Created by Geeven on 16/3/6.
//  Copyright © 2016年 Geeven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK: - 私有控件
    
    /// 画布
    private lazy var printView: GDDrawingView! = GDDrawingView()
}


// MARK: - 设置事件
extension ViewController {
    
    /// 清屏
    @IBAction func clearnScreen(sender: AnyObject) {
        printView.clearnScreen()
    }
    /// 上一退
    @IBAction func undo(sender: AnyObject) {
        printView.undo()
    }
    /// 橡皮
    @IBAction func eraser(sender: AnyObject) {
        printView.erase()
    }
    /// 选择图片
    @IBAction func choosePicture(sender: AnyObject) {
        
        let pickVc = UIImagePickerController()
        
        pickVc.sourceType = .SavedPhotosAlbum
        
        pickVc.delegate = self
        
        presentViewController(pickVc, animated: true, completion: nil)
        
    }
    /// 设置色彩
    @IBAction func chooseColor(sender: AnyObject) {
        
        
    }
    /// 设置线宽
    @IBAction func setLineWidth(sender: AnyObject) {
        
    }
    /// 保存图片到相册
    @IBAction func saveDrawing(sender: AnyObject) {
        
        printView.saveDrawing()
        
        let alertVc = UIAlertController(title: "操作提示", message: "成功保存到相册", preferredStyle: .Alert)
        let action:UIAlertAction = UIAlertAction(title: "确定", style:.Default, handler: nil)
        alertVc.addAction(action)
        presentViewController(alertVc, animated: true, completion: nil)
    }
    
}

//MARK: - UIImagePickerControllerDelegate
extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print(info)
        
        let image = info["UIImagePickerControllerOriginalImage"]
        
    }
}

extension ViewController {
    
    private func setUpUI() {
        
        view.addSubview(printView)
        printView.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
    }
}