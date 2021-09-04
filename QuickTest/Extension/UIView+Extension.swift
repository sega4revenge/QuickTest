//
//  UIViewExtension.swift
//  CarusStaff
//
//  Created by Techchain on 2/25/20.
//  Copyright © 2020 Techchain. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

typealias Gradient = (color: UIColor, location: Float)
extension UIView {
    
    func image() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func shadow(radius: CGFloat = 1, height: CGFloat = 1) {
        addShadow(ofColor: .gray, radius: 5, offset: CGSize(width: 3, height: 3), opacity: 0.5)
    }
    
    
    
    func setGradients(gradients: [Gradient], angle: Int = 0) {
        let tanValue = tan(Double(angle) * Double.pi / 180)
        
        let p1 = CGPoint(x: 0.5, y: 0.5)
        let p2y: Double = 0
        let p2x = 0.5 - (0.5 / tanValue)
        let p2 = CGPoint(x: p2x, y: p2y)
        
        // Default x value
        var startX: CGFloat = 0
        var endX: CGFloat = 1
        
        // Direction vector
        let vx = p2.x - p1.x
        let vy = p2.y - p1.y
        
        // Calculate y value
        let dental1 = -0.5 / vx
        var startY = 0.5 + vy * dental1
        let dental2 = 0.5 / vx
        var endY = 0.5 + vy * dental2
        
        // Case angle is multiple of 90 degree
        if (angle - 90) % 180 == 0 {
            startX = 0
            startY = 0
            endX = 0
            endY = 1
        }
        
        var colors = [CGColor]()
        var locations = [NSNumber]()
        for gradient in gradients {
            colors.append(gradient.color.cgColor)
            locations.append(NSNumber(value: gradient.location))
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: startX, y: startY)
        gradientLayer.endPoint = CGPoint(x: endX, y: endY)
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: Layout
extension UIView {
    func embed(in view: UIView, horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: vertical).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -vertical).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontal).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontal).isActive = true
    }
    
    func embed(in view: UIView, edges: UIEdgeInsets) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: edges.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edges.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edges.left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edges.right).isActive = true
    }
}

extension UISegmentedControl{
    func selectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .selected)
    }
    func unselectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}

extension UIView {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }

    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
    
    @IBInspectable
    var rotate: CGFloat {
        set {
            rotate(degrees: newValue)
        }
        
        get {
            return 0
        }
    }
    
    
    @IBInspectable
    var enableShadow: Bool {
        get {
            return true
        }
        
        set {
            guard newValue else { return }
            shadow(radius: enableShadowRadius, height: 2)
        }
    }
    
    @IBInspectable
    var enableShadowRadius: CGFloat {
        get {
            return 1
        }
    }
    
    @IBInspectable
    var topLeftRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners.insert(.layerMinXMinYCorner)
        }
    }
    
    @IBInspectable
    var topRightRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners.insert(.layerMaxXMinYCorner)
        }
    }
}

//Load nib
extension UIView {
    
    class var instanceFromNib: Self {
        return Bundle(for: Self.self)
            .loadNibNamed(String(describing: Self.self), owner: nil, options: nil)?.first as! Self
    }
}

