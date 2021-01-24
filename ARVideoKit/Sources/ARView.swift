//
//  ARView.swift
//  ARVideoKit
//
//  Created by Ahmed Bekhit on 10/14/17.
//  Copyright © 2017 Ahmed Fathi Bekhit. All rights reserved.
//

import UIKit
import ARKit

/**
 A class that configures the Augmented Reality View orientations.
 
 - Author: Ahmed Fathi Bekhit
 * [Github](http://github.com/AFathi)
 * [Website](http://ahmedbekhit.com)
 * [Twitter](http://twitter.com/iAFapps)
 * [Email](mailto:me@ahmedbekhit.com)
 */
@available(iOS 11.0, *)
@objc public class ARView: NSObject {
    private var _inputViewOrientations:[ARInputViewOrientation] = []
    
    /// An array of `ARInputViewOrientation` objects that allow customizing the accepted orientations in a `UIViewController` that contains Augmented Reality scenes.
    public var inputViewOrientations: [ARInputViewOrientation] {
        get{
            return _inputViewOrientations
        }
        set{
            if newValue.count == 0 {
                _inputViewOrientations = [.portrait]
            } else {
                _inputViewOrientations = newValue
            }
        }
    }
    
    private var ivom: ARInputViewOrientationMode = .auto
    /// An object that allow customizing which subviews will rotate in a `UIViewController` that contains Augmented Reality scenes.
    public var inputViewOrientationMode: ARInputViewOrientationMode {
        get{
            return ivom
        }
        set{
            ivom = newValue
        }
    }
    
    
    @objc init?(ARSceneKit: ARSCNView) {
        super.init()
    }
    
    @objc init?(ARSpriteKit: ARSKView) {
        super.init()
    }
    
    @objc init?(SceneKit: SCNView) {
        super.init()
    }
}
