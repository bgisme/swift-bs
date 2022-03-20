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
 
 */

import SwiftHtml

public class Breadcrumb: Component {
    
    public static let breadcrumbDividerKey = "--bs-breadcrumb-divider"
    public static let breadcrumbArrow = "url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;)"
    public static let breadcrumbDividerRemoved = "''"
        
    /// children ... BreadcrumbList
    public init(divider: String?, @TagBuilder contents: () -> [Tag]) {
        super.init {
            if let divider = divider {
                Nav { contents() }
                    .style(set: CssKeyValue(Self.breadcrumbDividerKey, divider))
            } else {
                Nav { contents() }
            }
        }
    }
}

public class BreadcrumbList: Component {
        
    /// children ... BreadcrumbListItem
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Ol {
                contents()
            }
            .class(insert: .breadcrumb)
        }
    }
}

public class BreadcrumbListItem: Component {
            
    public init(isActive: Bool = false, @TagBuilder contents: () -> [Tag]) {
        super.init {
            Li {
                contents()
            }
            .class(insert: .breadcrumbItem)
            .class(insert: .active, if: isActive)
        }
    }
}
