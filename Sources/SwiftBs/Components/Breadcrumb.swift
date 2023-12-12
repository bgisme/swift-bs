//
//  Breadcrumb.swift
//
//
//  Created by BG on 2/15/22.
//

/*
 
    Breadcrumb
        BreadcrumbList
            BreadcrumbItem
            BreadcrumbItem
 */

import SwiftHtml

open class Breadcrumb: Nav {
        
    public static let breadcrumbDividerKey = "--bs-breadcrumb-divider"
    public static let breadcrumbArrow = "url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;)"
    public static let breadcrumbDividerRemoved = "''"
    
    public convenience init(divider: String? = nil,
                            @TagBuilder items: () -> [BreadcrumbListItem]) {
        self.init(divider: divider) {
            BreadcrumbList(items: items)
        }
    }

    public init(divider: String? = nil,
                list: () -> BreadcrumbList) {
        let list = list()
        if let divider = divider {
            list.style(set: CssKeyValue(Self.breadcrumbDividerKey, divider))
        }
        super.init([list])
    }
}

open class BreadcrumbList: Ol {
    
    public init(@TagBuilder items: () -> [BreadcrumbListItem]) {
        super.init(items())
        self
            .class(insert: .breadcrumb)
    }
}

open class BreadcrumbListItem: Li {
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false) {
        self.init(isActive: isActive) {
            A(title).href(href)
        }
    }
    
    public init(isActive: Bool = false,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .breadcrumbItem)
            .isActive(if: isActive)
    }
    
    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        self.class(insert: .active, if: condition)
    }
}
