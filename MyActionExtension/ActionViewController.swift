//
//  ActionViewController.swift
//  MyActionExtension
//
//  Created by 片桐奏羽 on 2015/11/17.
//  Copyright (c) 2015年 katagiri. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        
        for item: AnyObject in self.extensionContext!.inputItems {
            let inputItem = item as! NSExtensionItem
            
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                
                // typeがイメージかチェック
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakImageView = self.imageView
                    
                    // イメージロード
                    itemProvider.loadItemForTypeIdentifier(kUTTypeImage as String, options: nil, completionHandler: { (image, error) in
                        if image != nil {
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                if let imageView = weakImageView {
                                    
                                    // イメージ変換
                                    let imageAfter = sepiaFilter((image as? UIImage)!)
                                    
                                    imageView.image = imageAfter
                                }
                            }
                        }
                    })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        
        // イメージを渡す
        let extensionItem = NSExtensionItem()
        let provider = NSItemProvider(item: self.imageView.image, typeIdentifier: kUTTypeImage as String)
        extensionItem.attachments = [provider]
        
        self.extensionContext!.completeRequestReturningItems([extensionItem], completionHandler: nil)
        
        
        
    }

}
