//
//  RecordAR+PhotoRender.swift
//  AR Video
//
//  Created by Ahmed Bekhit on 10/27/17.
//  Copyright © 2017 Ahmed Fathi Bekhit. All rights reserved.
//

import AVFoundation
import Photos
import UIKit

@available(iOS 11.0, *)
extension RecordAR {
    
    func adjustTime(current: CMTime, resume: CMTime, pause: CMTime) -> CMTime {
        return CMTimeSubtract(current, CMTimeSubtract(resume, pause))
    }
    
    func imageFromBuffer(buffer: CVPixelBuffer) -> UIImage {
        let coreImg = CIImage(cvPixelBuffer: buffer)
        let context = CIContext()
        let cgImg = context.createCGImage(coreImg, from: coreImg.extent)
        
        var angleEnabled: Bool {
            for v in inputViewOrientations {
                if UIDevice.current.orientation.rawValue == v.rawValue {
                    return true
                }
            }
            return false
        }

        let rotationAngle: CGFloat
        if !angleEnabled {
            rotationAngle = 0
        } else {
            rotationAngle = getRotationAngle()
        }

        return UIImage(cgImage: cgImg!).rotate(by: rotationAngle, flip: false)
    }

    @objc func appWillEnterBackground() {
        delegate?.recorder(willEnterBackground: status)
    }

    private func getRotationAngleForVideoOrientation() -> CGFloat {
        switch videoOrientation {
        case .auto:
            return getRotationAngle()
        case .alwaysPortrait:
            return 0
        case .alwaysLandscape:
            switch UIDevice.current.orientation {
            case .landscapeLeft:
                return -.pi/2
            case .landscapeRight:
                return .pi/2
            default:
                return 0
            }
        }
    }

    private func getRotationAngle() -> CGFloat {
        switch UIDevice.current.orientation {
        case .landscapeLeft:
            return -.pi/2
        case .landscapeRight:
            return .pi/2
        case .faceUp, .faceDown, .portraitUpsideDown:
            return 0
        default:
            return 0
        }
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
}
