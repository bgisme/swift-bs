
import SwiftHtml

open class PaginationNav: Nav {
    
    public convenience init(@TagBuilder pageItems: () -> [PageItem]) {
        self.init { Pagination(items: pageItems) }
    }
    
    public init(_ pagination: () -> Pagination) {
        super.init([pagination()])
    }
}

open class Pagination: Ul {
    
    public init(@TagBuilder items: () -> [PageItem]) {
        super.init(items())
        self
            .class(insert: Size.md.paginationClass.rawValue)
    }
}

extension Size {
    
    var paginationClass: Utility {
        switch self {
        case .xs, .sm:
            return .paginationSm
        case .md:
            return .pagination
        case .lg, .xl, .xxl:
            return .paginationLg
        }
    }
}

extension Pagination {
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        self
            .class(value.paginationClass.rawValue, condition)
    }
}

open class PageItem: Li {
        
    public convenience init(_ title: String, href: String) {
        self.init { PageLink(title, href: href) }
    }
    
    /// contents... PageLink
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .pageItem)
    }
}

extension PageItem {
    
    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        self
            .class(insert: .active, if: condition)
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        self
            .class(insert: .disabled, if: condition)
    }
}

open class PageLink: A {
    
    public convenience init(_ title: String, href: String) {
        self.init { Text(title) }
        self
            .href(href)
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .pageLink)
    }
}
