//
//  ViewController.swift
//  AppExtension
//
//  Created by 片桐奏羽 on 2015/11/17.
//  Copyright (c) 2015年 katagiri. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var imageViewBefore: UIImageView!

    @IBOutlet weak var imageViewAfter: UIImageView!
    @IBAction func actionButtonPushed(sender: AnyObject) {
        
        if (self.imageViewBefore.image == nil) {
            return
        }
        
        let activityVC : UIActivityViewController = UIActivityViewController(activityItems: [self.imageViewBefore.image!], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {(activityType, completed:Bool, anyObjects:[AnyObject]!, error:NSError!) in
            if (!completed) {
                // cancel
                return;
            }
            
            print("activityType:\(activityType)")
            print("anyObject:\(anyObjects.description)")
            
            for item: AnyObject in anyObjects{
                let extensionItem: NSExtensionItem = item as! NSExtensionItem
                
                let attachments = extensionItem.attachments!
                for attachment in attachments{
                    let itemProvider: NSItemProvider = attachment as! NSItemProvider
                    
                    // UTIについては、UTIs Use the Reverse Domain Name System Conventionを参照
                    if (itemProvider.hasItemConformingToTypeIdentifier(kUTTypeImage as String)) {
                  
                        // イメージのロード
                        itemProvider.loadItemForTypeIdentifier(kUTTypeImage as String, options: nil, completionHandler:
                            {
                                (image, error:NSError!) -> Void in
                                
                                // ビューにセット
                                dispatch_async(dispatch_get_main_queue(), {
                                    
                                    self.imageViewAfter.image = image as? UIImage
                                    
                                    
                                })

  
                                
                                
                            }
                        )
                    }
                    
                    
                }
            }
            
            
            //print("error:\(error.description)")
            
            
        }

        
            
        
        
        self.presentViewController(activityVC, animated: true, completion:nil)
        
        
    }
}

