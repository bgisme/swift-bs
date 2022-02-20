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
    
    public var divider: Style?
        
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
            self.divider = Style(.breadcrumbDivider, divider)
        }
        super.init(nil, nil, nil, children)
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
        .add(classes, attributes, styles)
        .style(add: divider, divider != nil)
    }
}

public class BreadcrumbItem: Component {
    
    let title: String
    let href: String?
    let isActive: Bool
    
    public init(_ title: String, href: String? = nil, isActive: Bool = false, classes: Classes? = nil, attributes: Attributes? = nil, styles: Styles? = nil, @TagBuilder children: @escaping () -> [Tag]) {
        self.title = title
        self.href = href
        self.isActive = isActive
        super.init(classes, attributes, styles, children)
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
        .add(classes, attributes, styles)
    }
}
