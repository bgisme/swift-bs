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
    
    public static func withList(divider: String? = nil,
                                @TagBuilder breadcrumbItems: () -> [Tag]) -> Breadcrumb {
        Breadcrumb(divider: divider, breadcrumbList: {
            BreadcrumbList {
                breadcrumbItems()
            }
        })
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
        self.init(nav)
    }
    
    public init(_ nav: Nav) {
        super.init(nav)
    }
}

public class BreadcrumbList: Component {
        
    /// contents ... BreadcrumbListItems
    public convenience init(@TagBuilder breadcrumbListItems: () -> [Tag]) {
        let ol = Ol {
            breadcrumbListItems()
        }
        self.init(ol)
    }
    
    public init(_ ol: Ol) {
        ol
            .class(insert: .breadcrumb)
        super.init(ol)
    }
}

public class BreadcrumbListItem: Component {
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false) {
        self.init(isActive: isActive) {
            A(title).href(href)
        }
    }
            
    /// contents ... anything
    public convenience init(isActive: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        let li = Li {
            contents()
        }
        self.init(isActive: isActive, li)
    }
    
    public init(isActive: Bool, _ li: Li) {
        li
            .class(insert: .breadcrumbItem)
            .class(insert: .active, if: isActive)

        super.init(li)
    }
}
