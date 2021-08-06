//
//  UIView+Extension.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//
import UIKit
extension UIView {
   @IBInspectable
    var cornerRadius : CGFloat{
        get { return self.cornerRadius}
        set { self.layer.cornerRadius = newValue}
    }
    
    @IBInspectable
    var borderWidth : CGFloat{
        get {return self.borderWidth }
        set {  layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
