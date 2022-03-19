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
    
    public init(size s: Size? = nil, ul: () -> Ul) {
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
            ul()
                .class(insert: .pagination)
                .class(insert: size)
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
        super.init {
            li()
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
