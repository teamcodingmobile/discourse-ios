//
//  UIImage+Extension.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 13/11/2020.
//

import UIKit

extension UIImage {
    static func gradient(from: UIColor, to: UIColor, frame: CGRect) -> UIImage {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [from.cgColor, to.cgColor]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        UIGraphicsBeginImageContext(gradient.frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
}
