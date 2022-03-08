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
    
//    public let divider: CssKeyValue?
    public let children: () -> [Tag]
        
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

    public init(divider: String?, @TagBuilder children: @escaping () -> [Tag]) {
        self.children = children
        super.init()
        if let divider = divider {
            self.styles = [BsCssProperty.breadcrumbDivider.rawValue : divider]
        }
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
