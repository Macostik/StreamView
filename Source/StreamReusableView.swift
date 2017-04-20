//
//  StreamReusableView.swift
//  StreamView
//
//  Created by Yura Granchenko on 4/11/17.
//  Copyright © 2017 Yura Granchenko. All rights reserved.
//

import Foundation
import UIKit

public class StreamReusableView: UIView, UIGestureRecognizerDelegate {
    
    public func setEntry(entry: Any?) {}
    public func getEntry() -> Any? { return nil }
    
    public var metrics: StreamMetricsProtocol?
    public var item: StreamItem?
    public var selected: Bool = false
    public let selectTapGestureRecognizer = UITapGestureRecognizer()
    
    public func layoutWithMetrics(metrics: StreamMetricsProtocol) {}
    
    public func didLoad() {
        selectTapGestureRecognizer.addTarget(self, action: #selector(self.selectAction))
        selectTapGestureRecognizer.delegate = self
        self.addGestureRecognizer(selectTapGestureRecognizer)
    }
    
    @IBAction func selectAction() {
        metrics?.select(view: self)
    }
    
    public func didDequeue() {}
    
    public func willEnqueue() {}
    
    public func resetup() {}
    
    // MARK: - UIGestureRecognizerDelegate
    
    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer != selectTapGestureRecognizer || metrics?.selectable ?? false
    }
}

public class EntryStreamReusableView<T: Any>: StreamReusableView {
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setEntry(entry: Any?) {
        self.entry = entry as? T
    }
    
    override public func getEntry() -> Any? {
        return entry
    }
    
    public var entry: T? {
        didSet {
            resetup()
        }
    }
    
    public func setup(entry: T) {}
    
    public func setupEmpty() {}
    
    override public func resetup() {
        if let entry = entry {
            setup(entry: entry)
        } else {
            setupEmpty()
        }
    }
}
