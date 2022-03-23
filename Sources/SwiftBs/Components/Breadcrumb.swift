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

public class Breadcrumb: Component {
    
    public static let breadcrumbDividerKey = "--bs-breadcrumb-divider"
    public static let breadcrumbArrow = "url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;)"
    public static let breadcrumbDividerRemoved = "''"
    
    public static func make(divider: String? = nil,
                            @TagBuilder breadcrumbItems: () -> [Tag]) -> Breadcrumb {
        Breadcrumb(divider: divider) {
            BreadcrumbList.make {
                breadcrumbItems()
            }
        }
    }
        
    public convenience init(divider: String? = nil,
                            breadcrumbList: () -> BreadcrumbList) {
        let nav: Nav
        if let divider = divider {
            nav = Nav {
                breadcrumbList()
            }
            .style(set: CssKeyValue(Self.breadcrumbDividerKey, divider))
        } else {
            nav = Nav {
                breadcrumbList()
            }
        }
        self.init {
            nav
        }
    }
    
    public init(nav: () -> Nav) {
        super.init {
            nav()
        }
    }
}

public class BreadcrumbList: Component {
        
    /// contents ... BreadcrumbListItems
    public static func make(@TagBuilder breadcrumbListItems: () -> [Tag]) -> BreadcrumbList {
        BreadcrumbList {
            Ol {
                breadcrumbListItems()
            }
        }
    }
    
    public init(ol: () -> Ol) {
        super.init {
            ol()
                .class(insert: .breadcrumb)
        }
    }
}

public class BreadcrumbListItem: Component {
    
    public static func make(_ title: String,
                            href: String,
                            isActive: Bool = false) -> BreadcrumbListItem {
        self.make(isActive: isActive) {
            A(title).href(href)
        }
    }
            
    /// contents ... anything
    public static func make(isActive: Bool = false,
                            @TagBuilder contents: () -> [Tag]) -> BreadcrumbListItem {
        BreadcrumbListItem(isActive: isActive) {
            Li {
                contents()
            }
        }
    }
    
    public init(isActive: Bool = false,
                li: () -> Li) {
        super.init {
            li()
                .class(insert: .breadcrumbItem)
                .class(insert: .active, if: isActive)
        }
    }
}
