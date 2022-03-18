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
                            @TagBuilder contents: () -> [Tag]) {
        let ul = Ul {
            contents()
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
