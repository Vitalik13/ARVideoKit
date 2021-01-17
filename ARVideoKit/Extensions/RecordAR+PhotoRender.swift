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

    private var angleEnabled: Bool {
        inputViewOrientations.contains(where: { $0.rawValue == UIDevice.current.orientation.rawValue })
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
                return -.pi/2
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
