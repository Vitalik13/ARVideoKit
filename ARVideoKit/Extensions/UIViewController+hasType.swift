//
//  UIViewController+hasType.swift
//  AR Video
//
//  Created by Ahmed Bekhit on 10/18/17.
//  Copyright © 2017 Ahmed Fathi Bekhit. All rights reserved.
//

import UIKit
import ARKit
import RealityKit

@available(iOS 11.0, *)
extension UIViewController {
    var hasARView: Bool {
        let views = self.view.subviews
        for v in views {
            var isRealityArView = false
            if #available(iOS 13.0, *) {
                isRealityArView = v is RealityKit.ARView
            }
            if v is ARSCNView || v is ARSKView || isRealityArView {
                return true
            }
        }
        return false
    }
}
