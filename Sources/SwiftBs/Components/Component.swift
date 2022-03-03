//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component {
    
    public typealias Class = BsClass

    public private(set) var markups: [Class]?   //! ELIMINATE
    public private(set) var children: () -> [Tag]
    public private(set) var classFlags = [CustomStringConvertible]()
    public var classString: String { classFlags.map{ $0.description }.joined(separator: " ") }
    
    public convenience init() {
        self.init {}
    }
    
    public init(@TagBuilder _ children: @escaping () -> [Tag]) {
        self.children = children
    }
    
    /// for declaring children after a series of function calls
    @discardableResult
    public func children(@TagBuilder _ children: @escaping () -> [Tag]) -> Self {
        self.children = children
        return self
    }
    
    @discardableResult
    public func bg(_ bg: Background, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        classFlags.append(bg)
        return self
    }
    
    @discardableResult
    public func m(_ side: Side, _ size: Size, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        classFlags.append(Spacing.m(side, size))
        return self
    }
    
    @discardableResult
    public func p(_ side: Side, _ size: Size, _ conddition: Bool = true) -> Self {
        guard conddition else { return self }
        classFlags.append(Spacing.p(side, size))
        return self
    }
}

/// These functions mimic Tag so they read the same when mixed together
extension Component {
    
    // MARK: - Classes
    
    @discardableResult
    public func `class`(_ classes: Class..., if condition: Bool = true) -> Self {
        self.class(classes, condition)
    }
    
    @discardableResult
    public func `class`(_ markups: [Class]?, _ condition: Bool = true) -> Self {
        if condition, let markups = markups {
            self.markups = markups
        }
        return self
    }

    @discardableResult
    public func `class`(add classes: Class..., if condition: Bool = true) -> Self {
        self.class(add: classes)
    }

    @discardableResult
    public func `class`(add markups: [Class]?, _ condition: Bool = true) -> Self {
        if condition, let markups = markups {
            self.markups = (self.markups != nil) ? self.markups! + markups : markups
        }
        return self
    }
}
