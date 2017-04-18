//
//  StreamLayout.swift
//  StreamView
//
//  Created by Yura Granchenko on 4/11/17.
//  Copyright © 2017 Yura Granchenko. All rights reserved.
//

import Foundation
import UIKit

public class StreamLayout {
    
    var horizontal: Bool { return false }
    
    var offset: CGFloat = 0
    
    var finalized = false
    
    func prepareLayout(streamView: StreamView) {
        finalized = false
    }
    
    func contentSize(item: StreamItem, streamView: StreamView) -> CGSize {
        if horizontal {
            return CGSize.init(width: item.frame.maxX, height: streamView.frame.height)
        } else {
            return CGSize.init(width: streamView.frame.width, height: item.frame.maxY)
        }
    }
    
    func recursivelyLayoutItem(item: StreamItem, streamView: StreamView) {
        var next: StreamItem? = item
        while let item = next {
            item.frame = frameForItem(item: item, streamView: streamView)
            next = item.next
        }
    }
    
    func layoutItem(item: StreamItem, streamView: StreamView) {
        item.frame = frameForItem(item: item, streamView: streamView)
    }
    
    func frameForItem(item: StreamItem, streamView: StreamView) -> CGRect {
        let size = item.size
        let insets = item.insets
        let offset = item.previous?.frame.maxY ?? self.offset
        return CGRect.init(x: insets.origin.x, y: offset + insets.origin.y, width: streamView.frame.width - insets.origin.x - insets.width, height: size + insets.height)
    }
    
    func prepareForNextSection() { }
    
    func finalizeLayout() {
        prepareForNextSection()
        finalized = true
    }
}

public class HorizontalStreamLayout: StreamLayout {
    
    override var horizontal: Bool { return true }
    
    override func frameForItem(item: StreamItem, streamView: StreamView) -> CGRect {
        let size = item.size
        let insets = item.insets
        let offset = item.previous?.frame.maxX ?? self.offset
        return CGRect.init(x: offset + insets.origin.x, y: insets.origin.y, width: size + insets.width, height: streamView.frame.height - insets.origin.y - insets.height)
    }
}

public class HorizontalViсeVersaStreamLayout: StreamLayout {
    
    override var horizontal: Bool { return true }
    
    override func frameForItem(item: StreamItem, streamView: StreamView) -> CGRect {
        let size = item.size
        let insets = item.insets
        let offset = item.previous?.frame.minX ?? UIScreen.main.bounds.width
        return CGRect.init(x: offset - size, y: insets.origin.y, width: size + insets.width, height: streamView.frame.height - insets.origin.y - insets.height)
    }
}
