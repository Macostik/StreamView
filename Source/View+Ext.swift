//
//  View+Ext.swift
//  StreamView
//
//  Created by Yura Granchenko on 4/11/17.
//  Copyright © 2017 Yura Granchenko. All rights reserved.
//

import Foundation
import UIKit

func ^(lhs: CGFloat, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs, y: rhs)
}

func ^(lhs: CGFloat, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs, height: rhs)
}

func ^(lhs: CGPoint, rhs: CGSize) -> CGRect {
    return CGRect(origin: lhs, size: rhs)
}

func smoothstep(_ _min: CGFloat = 0, _ _max: CGFloat = 1, _ value: CGFloat) -> CGFloat {
    return max(_min, min(_max, value))
}

extension UIView {
    
    var x: CGFloat {
        set { frame.origin.x = newValue }
        get { return frame.origin.x }
    }
    
    var y: CGFloat {
        set { frame.origin.y = newValue }
        get { return frame.origin.y }
    }
    
    var width: CGFloat {
        set { frame.size.width = newValue }
        get { return frame.size.width }
    }
    
    var height: CGFloat {
        set { frame.size.height = newValue }
        get { return frame.size.height }
    }
    
    var size: CGSize {
        set { frame.size = newValue }
        get { return frame.size }
    }
    
    var centerBoundary: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    @discardableResult func add<T: UIView>(_ subview: T) -> T {
        addSubview(subview)
        return subview
    }
}
