////
////  Breadcrumb.swift
////
////
////  Created by BG on 2/15/22.
////

import SwiftHtml

public class Breadcrumb: Component {
    
    public typealias Title = String
    public typealias Href = String
    
    public var divider: CssKeyValue?
        
    public convenience init(_ items: (Title, Href?)..., divider: String? = nil) {
        self.init(items, divider: divider)
    }
    
    public convenience init(_ items: [(Title, Href?)], divider: String? = nil) {
        self.init(divider: divider) {
            items.map {
                BreadcrumbItem($0.0, href: $0.1) {}
            }
        }
    }

    public init(divider: String? = nil, @TagBuilder children: @escaping () -> [Tag]) {
        if let divider = divider {
            self.divider = CssKeyValue(.breadcrumbDivider, divider)
        }
        super.init() { children() }
    }
}

extension Breadcrumb: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Nav {
            Ol {
                children()
            }
            .class(.breadcrumb)
        }
        .class(add: markups)
        .style(add: divider, divider != nil)
    }
}

public class BreadcrumbItem: Component {
    
    let title: String
    let href: String?
    let isActive: Bool
    
    public init(_ title: String, href: String? = nil, isActive: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.title = title
        self.href = href
        self.isActive = isActive
        super.init() { children() }
    }
}

extension BreadcrumbItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Li {
            A {
                Text(title)
                children()
            }
            .hrefOptional(href)
        }
        .class(.breadcrumbItem)
        .class(add: .active, if: isActive)
        .class(add: markups)
    }
}
