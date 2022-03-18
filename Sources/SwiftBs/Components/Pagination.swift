//
//  Pagination.swift
//  
//
//  Created by Brad Gourley on 3/18/22.
//

import SwiftHtml

public class Pagination: Component {
    
    public enum Size {
        case sm
        case lg
    }
    
    let ul: Ul
    let size: BsClass?
    
    public init(size: Size? = nil, ul: () -> Ul) {
        switch size {
        case .sm:
            self.size = .paginationSm
        case .lg:
            self.size = .paginationLg
        default:
            self.size = nil
        }
        self.ul = ul()
    }
}

extension Pagination: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        ul
            .class(add: .pagination)
            .class(add: size)
            .merge(attributes)
    }
}

public class PageItem: Component {
    
    let li: Li
    let isActive: Bool
    let isDisabled: Bool
    
    public convenience init(_ title: String,
                            href: String,
                            ariaLabel: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(isActive: isActive, isDisabled: isDisabled) {
            Li { PageLink(title, href: href, ariaLabel: ariaLabel) }
        }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            pageLink: () -> PageLink) {
        self.init(isActive: isActive, isDisabled: isDisabled) { Li { pageLink() } }
    }
    
    public init(isActive: Bool = false,
                isDisabled: Bool = false,
                li: () -> Li) {
        self.isActive = isActive
        self.isDisabled = isDisabled
        self.li = li()
    }
}

extension PageItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        li
            .class(add: .pageItem)
            .class(add: .active, if: isActive)
            .class(add: .disabled, if: isDisabled)
            .merge(attributes)
    }
}

public class PageLink: Component {
    
    let a: A
    let ariaLabel: String
    
    public convenience init(_ title: String,
                            href: String,
                            ariaLabel: String) {
        self.init(ariaLabel: ariaLabel) { A(title).href(href) }
    }
    
    public init(ariaLabel: String, a: () -> A) {
        self.ariaLabel = ariaLabel
        self.a = a()
    }
}

extension PageLink: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        a
            .class(add: .pageLink)
            .merge(attributes)
    }
}
