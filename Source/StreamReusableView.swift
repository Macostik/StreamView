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
    
    func setEntry(entry: Any?) {}
    func getEntry() -> Any? { return nil }
    
    var metrics: StreamMetricsProtocol?
    var item: StreamItem?
    var selected: Bool = false
    let selectTapGestureRecognizer = UITapGestureRecognizer()
    
    func layoutWithMetrics(metrics: StreamMetricsProtocol) {}
    
    func didLoad() {
        selectTapGestureRecognizer.addTarget(self, action: #selector(self.selectAction))
        selectTapGestureRecognizer.delegate = self
        self.addGestureRecognizer(selectTapGestureRecognizer)
    }
    
    @IBAction func selectAction() {
        metrics?.select(view: self)
    }
    
    func didDequeue() {}
    
    func willEnqueue() {}
    
    func resetup() {}
    
    // MARK: - UIGestureRecognizerDelegate
    
    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer != selectTapGestureRecognizer || metrics?.selectable ?? false
    }
}

class EntryStreamReusableView<T: Any>: StreamReusableView {
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setEntry(entry: Any?) {
        self.entry = entry as? T
    }
    
    override func getEntry() -> Any? {
        return entry
    }
    
    var entry: T? {
        didSet {
            resetup()
        }
    }
    
    func setup(entry: T) {
    }
    
    func setupEmpty() {}
    
    override func resetup() {
        if let entry = entry {
            setup(entry: entry)
        } else {
            setupEmpty()
        }
    }
}
