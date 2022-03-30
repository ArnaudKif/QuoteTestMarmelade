//
//  extension.swift
//  QuoteTestMarmelade
//
//  Created by arnaud kiefer on 30/03/2022.
//

import Foundation
import UIKit
//
//class TopRoundedView: UIView {
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.topLeft | UIRectCorner.topRight, cornerRadii: CGSize(width: 5.0, height: 5.0))
//        //(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.TopLeft (|).rawValue, UIRectCorner.TopRight, cornerRadii: CGSizeMake(5.0, 5.0))
//
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = self.bounds
//        maskLayer.path = maskPath.cgPath
//
//        self.layer.mask = maskLayer
//    }
//
////    var view = UILabel()
////    view.frame = CGRect(x: 0, y: 0, width: 375, height: 530)
////    view.backgroundColor = .white
//
//    var shadows = UIView()
//    shadows.frame = view.frame
//    shadows.clipsToBounds = false
//    view.addSubview(shadows)
//
//    let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
//    let layer0 = CALayer()
//    layer0.shadowPath = shadowPath0.cgPath
//    layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
//    layer0.shadowOpacity = 1
//    layer0.shadowRadius = 13
//    layer0.shadowOffset = CGSize(width: 0, height: -10)
//    layer0.bounds = shadows.bounds
//    layer0.position = shadows.center
//    shadows.layer.addSublayer(layer0)
//
//    var shapes = UIView()
//    shapes.frame = view.frame
//    shapes.clipsToBounds = true
//    view.addSubview(shapes)
//
////    let layer1 = CALayer()
////    layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
////    layer1.bounds = shapes.bounds
////    layer1.position = shapes.center
////    shapes.layer.addSublayer(layer1)
//
//
//    var parent = self.view!
//    parent.addSubview(view)
//    view.translatesAutoresizingMaskIntoConstraints = false
//
//}
