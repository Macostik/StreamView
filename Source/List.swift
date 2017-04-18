//
//  List.swift
//  StreamView
//
//  Created by Yura Granchenko on 4/11/17.
//  Copyright © 2017 Yura Granchenko. All rights reserved.
//

import Foundation

class List<T: Equatable> {
    
    var sorter: (_ lhs: T, _ rhs: T) -> Bool = { _ in return true }
    
    convenience init(sorter: @escaping (_ lhs: T, _ rhs: T) -> Bool) {
        self.init()
        self.sorter = sorter
    }
    
    var entries = [T]()
    
    internal func _add(entry: T) -> Bool {
        if !entries.contains(entry) {
            entries.append(entry)
            return true
        } else {
            return false
        }
    }
    
    func add(entry: T) {
        if _add(entry: entry) {
            sort()
        }
    }
    
    func addEntries<S: Sequence>(entries: S) where S.Iterator.Element == T {
        let count = self.entries.count
        for entry in entries {
            let _ = _add(entry: entry)
        }
        if count != self.entries.count {
            sort()
        }
    }
    
    func sort(entry: T) {
        let _ = _add(entry: entry)
        sort()
    }
    
    func sort() {
        entries = entries.sorted(by: sorter)
    }
    
    func remove(entry: T) {
        if let index = entries.index(of: entry) {
            entries.remove(at: index)
        }
    }
    
    subscript(index: Int) -> T? {
        return (index >= 0 && index < count) ? entries[index] : nil
    }
}

protocol BaseOrderedContainer {
    associatedtype ElementType
    var count: Int { get }
    subscript (safe index: Int) -> ElementType? { get }
}

extension Array: BaseOrderedContainer {}

extension List: BaseOrderedContainer {
    var count: Int { return entries.count }
    subscript (safe index: Int) -> T? {
        return entries[safe: index]
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return (index >= 0 && index < count) ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    
    mutating func remove(_ element: Element) {
        if let index = index(of: element) {
            self.remove(at: index)
        }
    }
}

extension Collection {
    
    func all(_ enumerator: (Iterator.Element) -> Void) {
        for element in self {
            enumerator(element)
        }
    }
    
    subscript (includeElement: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in self where includeElement(element) == true {
            return element
        }
        return nil
    }
}

extension Dictionary {
    
    func get<T>(_ key: Key) -> T? {
        return self[key] as? T
    }
}
