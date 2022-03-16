//
//  NavTabs.swift
//  
//
//  Created by Brad Gourley on 3/16/22.
//

import SwiftHtml

public class NavTabs: Component {
    
    let tag: Tag
    
    public convenience init(_ nav: Nav) {
        self.init(tag: nav)
    }
    
    public convenience init(_ ol: Ol) {
        self.init(tag: ol)
    }
    
    public convenience init(_ ul: Ul) {
        self.init(tag: ul)
    }
    
    internal init(tag: Tag) {
        self.tag = tag
    }
}

extension NavTabs: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .nav)
            .merge(self.attributes)
    }
}

public class NavItem: Component {
    
    let li: Li
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        let li = Li {
            Text(title)
            NavLink(title, href: href, isActive: isActive, isDisabled: isDisabled)
        }
        self.init(li)
    }
    
    public init(_ li: Li) {
        self.li = li
    }
}

extension NavItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        li
            .class(add: .navItem)
            .merge(self.attributes)
    }
}

public class NavLink: Component {
    
    let a: A
    let isActive: Bool
    let isDisabled: Bool
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        let a = A(title).href(href)
        self.init(a, isActive: isActive, isDisabled: isDisabled)
    }
    
    public init(_ a: A, isActive: Bool = false, isDisabled: Bool = false) {
        self.a = a
        self.isActive = isActive
        self.isDisabled = isDisabled
    }
}

extension NavLink: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        a
            .class(add: .navLink)
            .class(add: .active, if: isActive)
            .ariaCurrent(isActive)
            .class(add: .disabled, if: isDisabled)
            .merge(self.attributes)
    }
}
