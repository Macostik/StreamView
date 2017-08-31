//
//  PlaceholderView.swift
//  StreamView
//
//  Created by Yura Granchenko on 4/20/17.
//  Copyright © 2017 Yura Granchenko. All rights reserved.
//

import Foundation


public class PlaceholderView: UIView {
    
    public let textLabel = UILabel()
    public let iconLabel = UILabel()
    
    static public func placeholderView(specify views: @escaping (PlaceholderView) -> ()) -> (() -> PlaceholderView) {
        return {
            let view = PlaceholderView()
            view.isUserInteractionEnabled = false
            views(view)
     
            return view
        }
    }
}

