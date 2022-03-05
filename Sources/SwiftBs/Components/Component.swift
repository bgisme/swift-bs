//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component {
    
    public private(set) var bsClasses: [BsClass]?
    public private(set) var styles: [CssKeyValue]?
}

/// These functions mimic Tag so they read the same when mixed together
extension Component {
    
    // MARK: - Classes
    
    @discardableResult
    public func `class`(_ classes: BsClass..., if condition: Bool = true) -> Self {
        self.class(classes, condition)
    }
    
    @discardableResult
    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
        if condition, let classes = classes {
            self.bsClasses = classes
        }
        return self
    }

    @discardableResult
    public func `class`(add classes: BsClass..., if condition: Bool = true) -> Self {
        self.class(add: classes)
    }

    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        if condition, let classes = classes {
            self.bsClasses = (self.bsClasses != nil) ? self.bsClasses! + classes : classes
        }
        return self
    }
    
    // MARK: Styles
    
    @discardableResult
    public func style(_ styles: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        guard let styles = styles, condition else { return self }
        self.styles = self.styles != nil ? self.styles! + styles : styles
        return self
    }
}
