//
//  Pagination.swift
//  
//
//  Created by Brad Gourley on 3/18/22.
//

import SwiftHtml

public class PaginationNav: Component {
    
    public convenience init(ariaLabel: String,
                            size s: Pagination.Size? = nil,
                            @TagBuilder pageItems: () -> [Tag]) {
        self.init {
            Pagination(ariaLabel: ariaLabel) {
                pageItems()
            }
        }
    }
    
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
    
    public enum Size {
        case sm
        case lg
    }
    
    public convenience init(ariaLabel: String,
                            size s: Size? = nil,
                            @TagBuilder pageItems: () -> [Tag]) {
        let size: BsClass?
        switch s {
        case .sm:
            size = .paginationSm
        case .lg:
            size = .paginationLg
        default:
            size = nil
        }
        let nav = Nav {
            Ul {
                
            }
            .class(insert: .pagination)
            .class(insert: size)
        }
        self.init(ariaLabel: ariaLabel, nav)
    }
    
    public init(ariaLabel: String, _ nav: Nav) {
        nav
            .ariaLabel(ariaLabel)

        super.init(nav)
    }
}

public class PageItem: Component {
    
    public convenience init(_ title: String,
                            href: String,
                            ariaLabel: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(isActive: isActive, isDisabled: isDisabled) {
            PageLink(title, href: href, ariaLabel: ariaLabel)
        }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            pageLink: () -> PageLink) {
        let li = Li { pageLink() }
        self.init(isActive: isActive, isDisabled: isDisabled, li)
    }
    
    public init(isActive: Bool = false,
                isDisabled: Bool = false,
                _ li: Li) {
        li
            .class(insert: .pageItem)
            .class(insert: .active, if: isActive)
            .class(insert: .disabled, if: isDisabled)
        
        super.init(li)
    }
}

public class PageLink: Component {
    
    public convenience init(_ title: String,
                            href: String,
                            ariaLabel: String) {
        let a = A(title).href(href)
        self.init(ariaLabel: ariaLabel, a)
    }
    
    public init(ariaLabel: String, _ a: A) {
        a
            .class(insert: .pageLink)
            .ariaLabel(ariaLabel)

        super.init(a)
    }
}
