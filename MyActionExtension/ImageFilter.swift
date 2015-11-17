//
//  ImageFilter.swift
//  AppExtension
//
//  Created by 片桐奏羽 on 2015/11/17.
//  Copyright (c) 2015年 katagiri. All rights reserved.
//

import Foundation
import UIKit
import CoreImage


// filterの一覧はCore Image Filter Referenceにあり。
func sepiaFilter(image:UIImage) -> UIImage?
{
    
    let ciImage = CIImage(image: image)
    let filter = CIFilter(name: "CISepiaTone")
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    filter.setValue(0.8, forKey: "inputIntensity")
    let ciContext = CIContext(options: nil)
    let cgimg = ciContext.createCGImage(filter.outputImage, fromRect: filter.outputImage.extent())
    
    let resImage = UIImage(CGImage: cgimg, scale: 1.0, orientation: UIImageOrientation.Up)
    
    return resImage
}