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
    
    public convenience init(size: Size? = nil,
                            @TagBuilder pageItems: () -> [Tag]) {
        let ul = Ul {
            pageItems()
        }
        self.init(ul, size: size)
    }
    
    public init(_ ul: Ul, size: Size? = nil) {
        self.ul = ul
        switch size {
        case .sm:
            self.size = .paginationSm
        case .lg:
            self.size = .paginationLg
        default:
            self.size = nil
        }
    }
}

extension Pagination: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        ul
            .class(add: .pagination)
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
        let li = Li {
            PageLink(title, href: href, ariaLabel: ariaLabel)
        }
        self.init(li, isActive: isActive, isDisabled: isDisabled)
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            @TagBuilder pageLink: () -> [Tag]) {
        let li = Li {
            pageLink()
        }
        self.init(li, isActive: isActive, isDisabled: isDisabled)
    }
    
    public init(_ li: Li,
                isActive: Bool = false,
                isDisabled: Bool = false) {
        self.li = li
        self.isActive = isActive
        self.isDisabled = isDisabled
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
        let a = A(title)
            .href(href)
        self.init(a, ariaLabel: ariaLabel)
    }
    
    public convenience init(ariaLabel: String, @TagBuilder contents: () -> [Tag]) {
        let a = A {
            contents()
        }
        self.init(a, ariaLabel: ariaLabel)
    }
    
    public init(_ a: A, ariaLabel: String) {
        self.a = a
        self.ariaLabel = ariaLabel
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
