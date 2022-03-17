//
//  Breadcrumb.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Breadcrumb: Component {
    
    public typealias Title = String
    public typealias Href = String

    public static let breadcrumbDividerKey = "--bs-breadcrumb-divider"
    public static let breadcrumbArrow = "url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;)"
    public static let breadcrumbDividerRemoved = "''"
    
    let ol: Ol
        
    public convenience init(_ items: (Title, Href)..., divider: String? = nil) {
        self.init(items, divider: divider)
    }
    
    public convenience init(_ items: [(Title, Href)], divider: String? = nil) {
        self.init(divider: divider) {
            items.map {
                BreadcrumbItem($0.0, href: $0.1)
            }
        }
    }

    public convenience init(divider: String?, @TagBuilder children: @escaping () -> [Tag]) {
        let ol = Ol { children() }
        self.init(ol)
        if let divider = divider {
            style(add: [(Self.breadcrumbDividerKey, divider)])
        }
    }
    
    public init(_ ol: Ol) {
        self.ol = ol
    }
}

extension Breadcrumb: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Nav {
            ol
                .class(add: .breadcrumb)
        }
        .merge(attributes)
    }
}

public class BreadcrumbItem: Component {
    
    let a: A
    let isActive: Bool
        
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false) {
        self.init(A(title).href(href), isActive: isActive)
    }
    
    public init(_ a: A, isActive: Bool = false) {
        self.a = a
        self.isActive = isActive
    }
}

extension BreadcrumbItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Li {
            a
        }
        .class(add: .breadcrumbItem)
        .class(add: .active, if: isActive)
        .merge(attributes)
    }
}
