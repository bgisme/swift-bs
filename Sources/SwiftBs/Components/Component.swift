//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component {
    
    public private(set) var bsClasses: [BsClass]?
    public private(set) var styles: [String : String]?
}

/// These functions mimic Tag so they read the same when mixed together
extension Component {
    
    // MARK: - Classes
    
    @discardableResult
    public func `class`(_ classes: BsClass?..., if condition: Bool = true) -> Self {
        let classes = classes.compactMap { $0 }
        guard condition, !classes.isEmpty else { return self }
        return self.class(classes, condition)
    }
    
    @discardableResult
    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard condition, let classes = classes else { return self }
        self.bsClasses = classes
        return self
    }

    @discardableResult
    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
        let classes = classes.compactMap {$0}
        guard condition, !classes.isEmpty else { return self }
        return self.class(add: classes)
    }

    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard condition, let classes = classes else { return self }
        self.bsClasses = (self.bsClasses != nil) ? self.bsClasses! + classes : classes
        return self
    }
    
    // MARK: Styles
    
    @discardableResult
    public func style(_ styles: CssKeyValue?..., if condition: Bool = true) -> Self {
        let styles = styles.compactMap { $0 }
        guard condition, !styles.isEmpty else { return self }
        return self.style(styles, condition)
    }
    
    @discardableResult
    public func style(_ styles: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        guard condition, let styles = styles, !styles.isEmpty else { return self }
        if self.styles == nil { self.styles = [:] }
        _ = styles.map { self.styles?[$0.key] = $0.value }
        return self
    }    
}
