
import SwiftHtml

public class PaginationNav: Component {
    
    /// contents ... Pagination
    public convenience init(pagination: () -> Pagination) {
        let nav = Nav { pagination() }
        self.init(nav)
    }
    
    public init(_ nav: Nav) {
        super.init(nav)
    }
}

public class Pagination: Component {
    
    public convenience init(@TagBuilder pageItems: () -> [Tag]) {
        let ul = Ul { pageItems() }
        self.init(ul)
    }
    
    public init(_ ul: Ul) {
        ul
            .class(insert: Size.md.paginationClass)

        super.init(ul)
    }
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        guard condition, value != Size.md else { return self }
        tag
            .class(insert: value.paginationClass)
        return self
    }
}

public class PageItem: Component {
    
    public convenience init(_ title: String, href: String) {
        self.init {
            PageLink(title, href: href)
        }
    }
    
    public convenience init(pageLink: () -> PageLink) {
        let li = Li { pageLink() }
        self.init(li)
    }
    
    public init(_ li: Li) {
        li
            .class(insert: .pageItem)
        
        super.init(li)
    }
    
    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        tag
            .class(insert: .active, if: condition)
        return self
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        tag
            .class(insert: .disabled, if: condition)
        return self
    }
}

public class PageLink: Component {
    
    public convenience init(_ title: String, href: String) {
        self.init {
            A(title).href(href)
        }
    }
    
    public convenience init(a: () -> A) {
        self.init(a())
    }
    
    public init(_ a: A) {
        a
            .class(insert: .pageLink)

        super.init(a)
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
