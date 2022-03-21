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
    public init(pagination: () -> Pagination) {
        super.init {
            Nav{ pagination() }
        }
    }
}

public class Pagination: Component {
    
    public enum Size {
        case sm
        case lg
    }
    
    public init(ariaLabel: String,
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
        super.init {
            Nav {
                Ul {
                    
                }
                .class(insert: .pagination)
                .class(insert: size)
            }
            .ariaLabel(ariaLabel)
        }
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
    
    public init(isActive: Bool = false,
                isDisabled: Bool = false,
                pageLink: () -> PageLink) {
        super.init {
            Li {
                pageLink()
            }
            .class(insert: .pageItem)
            .class(insert: .active, if: isActive)
            .class(insert: .disabled, if: isDisabled)
        }
    }
}

public class PageLink: Component {
    
    public convenience init(_ title: String,
                            href: String,
                            ariaLabel: String) {
        self.init(ariaLabel: ariaLabel) { A(title).href(href) }
    }
    
    public init(ariaLabel: String, a: () -> A) {
        super.init {
            a()
                .class(insert: .pageLink)
                .ariaLabel(ariaLabel)
        }
    }
}
