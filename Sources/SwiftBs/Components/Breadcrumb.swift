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
            self.styles = [BsCssProperty.breadcrumbDivider.rawValue : divider]
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
                .class(.breadcrumb)
        }
        .addClassesStyles(self)
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
        .class(.breadcrumbItem)
        .class(add: .active, if: isActive)
        .addClassesStyles(self)
    }
}
