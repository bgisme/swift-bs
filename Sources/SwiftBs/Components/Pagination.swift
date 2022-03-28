//
//  Pagination.swift
//  
//
//  Created by Brad Gourley on 3/18/22.
//

import SwiftHtml

public class PaginationNav: Component {
    
    /// contents ... Pagination
    public convenience init(pagination: () -> Pagination) {
        let nav = Nav { pagination() }
        self.init(nav)
    }
    
    public init(_ nav: Nav) {
        super.init(nav)
    }
}

public class Pagination: Component {
    
    public convenience init(@TagBuilder pageItems: () -> [Tag]) {
        let ul = Ul { pageItems() }
        self.init(ul)
    }
    
    public init(_ ul: Ul) {
        ul
            .class(insert: Size.md.paginationClass)

        super.init(ul)
    }
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        guard condition, value != Size.md else { return self }
        tag
            .class(insert: value.paginationClass)
        return self
    }
}

public class PageItem: Component {
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(isActive: isActive, isDisabled: isDisabled) {
            PageLink(title, href: href)
        }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            pageLink: () -> PageLink) {
        let li = Li { pageLink() }
        self.init(isActive: isActive, isDisabled: isDisabled, li)
    }
    
    public init(isActive: Bool,
                isDisabled: Bool,
                _ li: Li) {
        li
            .class(insert: .pageItem)
            .class(insert: .active, if: isActive)
            .class(insert: .disabled, if: isDisabled)
        
        super.init(li)
    }
}

public class PageLink: Component {
    
    public convenience init(_ title: String, href: String) {
        self.init {
            A(title).href(href)
        }
    }
    
    public convenience init(a: () -> A) {
        self.init(a())
    }
    
    public init(_ a: A) {
        a
            .class(insert: .pageLink)

        super.init(a)
    }
}

extension Size {
    
    var paginationClass: BsClass {
        switch self {
        case .xs, .sm:
            return .paginationSm
        case .md:
            return .pagination
        case .lg, .xl, .xxl:
            return .paginationLg
        }
    }
}
