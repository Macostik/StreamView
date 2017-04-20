//
//  StreamDataSource.swift
//  StreamView
//
//  Created by Yura Granchenko on 4/11/17.
//  Copyright © 2017 Yura Granchenko. All rights reserved.
//

import Foundation
import UIKit

public class StreamDataSource<T: BaseOrderedContainer>: NSObject, StreamViewDataSource, UIScrollViewDelegate where T.ElementType: Any {
    
    public var streamView: StreamView
    
    public var sectionHeaderMetrics = [StreamMetricsProtocol]()
    
    public var metrics = [StreamMetricsProtocol]()
    
    public var sectionFooterMetrics = [StreamMetricsProtocol]()
    
    deinit {
        if (streamView.delegate as? StreamDataSource) == self {
            streamView.delegate = nil
        }
    }
    
    public var items: T? {
        didSet {
            didSetItems()
        }
    }
    
    public func didSetItems() {
        reload()
    }
    
    public func reload() {
        if streamView.dataSource as? StreamDataSource == self {
            streamView.reload()
        }
    }
    
    @discardableResult public func addSectionHeaderMetrics<T: StreamMetricsProtocol>(metrics: T) -> T {
        sectionHeaderMetrics.append(metrics)
        return metrics
    }
    
    @discardableResult public func addMetrics<T: StreamMetricsProtocol>(metrics: T) -> T {
        self.metrics.append(metrics)
        return metrics
    }
    
    @discardableResult public func addSectionFooterMetrics<T: StreamMetricsProtocol>(metrics: T) -> T {
        sectionFooterMetrics.append(metrics)
        return metrics
    }
    
    required public init(streamView: StreamView) {
        self.streamView = streamView
        super.init()
        self.streamView = streamView
        streamView.delegate = self
        streamView.dataSource = self
      
    }
    
    public var numberOfItems: Int?
    
    public var didLayoutItemBlock: ((StreamItem) -> Void)?
    
    private func entryForItem(item: StreamItem) -> Any? {
        return items?[safe: item.position.index]
    }
    
    public func numberOfItemsIn(section: Int) -> Int {
        return numberOfItems ?? items?.count ?? 0
    }
    
    public func metricsAt(position: StreamPosition) -> [StreamMetricsProtocol] {
        return metrics
    }
    
    public func didLayoutItem(item: StreamItem) {
        didLayoutItemBlock?(item)
    }
    
    public func entryBlockForItem(item: StreamItem) -> ((StreamItem) -> Any?)? {
        return { [weak self] item -> Any? in
            return self?.entryForItem(item: item)
        }
    }
    
    public func didChangeContentSize(oldContentSize: CGSize) {}
    
    public func didLayout() {}
    
    public func headerMetricsIn(section: Int) -> [StreamMetricsProtocol] {
        return sectionHeaderMetrics
    }
    
    public func footerMetricsIn(section: Int) -> [StreamMetricsProtocol] {
        return sectionFooterMetrics
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public var didEndDecelerating: (() -> ())?
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            didEndDecelerating?()
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didEndDecelerating?()
    }
}
