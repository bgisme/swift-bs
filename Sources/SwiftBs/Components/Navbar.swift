//
//  File.swift
//  
//
//  Created by BG on 2/12/22.
//

import SwiftHtml

public class Navbar: Component {
    
    var isListBased: Bool
    var brand: () -> [Tag]

    public init(isListBased: Bool = true, @TagBuilder brand: @escaping () -> [Tag], @TagBuilder items: @escaping () -> [Tag]) {
        self.isListBased = isListBased
        self.brand = brand
        super.init() { items() }
    }
}

extension Navbar: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Nav {
            Div {
                brand()
                Button {
                    Span {}.class(.navbarTogglerIcon)
                }
                .class(.navbarToggler)
                .type(.button)
                .dataToggle(.collapse)
                .dataTarget(.navbarSupportedContent)
                .ariaControls(.navbarSupportedContent)
                .ariaExpanded(String(false))
                .ariaLabelledBy("Toggle navigation")
                
                Div {
                    if isListBased {
                        Ul() {
                            children()
                        }
                        .class(.navbarNav)
                    } else {
                        children()
                    }
                }
                .class(add: .collapse, .navbarCollapse)
                .id("navbarSupportedContent")
            }
            .class(.containerFluid)
        }
        .class(.navbar)
        .add(classes, attributes, styles)
    }
}

public class NavbarBrand: Component {
    
    let src: String?
    let alt: String?
    let text: String?
    let href: String?
    
    /// Text with-without Href
    public convenience init(_ text: String, href: String?) {
        self.init(src: nil, alt: nil, text: text, href: href){}
    }
    
    /// Img with-without Text with-without Href
    public convenience init(_ imgSrc: String, alt: String, text: String?, href: String?) {
        self.init(src: imgSrc, alt: alt, text: text, href: href){}
    }
    
    /// Convenience inits insure correct combination of parameters supplied
    private init(src: String?, alt: String?, text: String?, href: String?, @TagBuilder children: @escaping () -> [Tag]) {
        self.src = src
        self.alt = alt
        self.text = text
        self.href = href
        super.init() { children() }
    }
}

extension NavbarBrand: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        A {
            if let src = src {
                // Image and text
                Img(src: src, alt: alt ?? "Icon")
                    .width(30)
                    .height(24)
            }
            if let text = text {
                Text(text)
            }
            children()
        }
        .class(.navbarBrand)
        .hrefOptional(href)
        .class(add: .h1, .mb0, if: href == nil)
        .class(add: .dInlineBlock, .alignTextTop, if: src != nil && text != nil)
        .add(classes, attributes, styles)
    }
}

public class NavDropdown: Component {
    
    let title: String
    
    public init(_ title: String, classes: Classes? = nil, attributes: Attributes? = nil, styles: Styles? = nil, @TagBuilder children: @escaping () -> [Tag]) {
        self.title = title
        super.init(classes, attributes, styles, children)
    }
}

extension NavDropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Li {
            A(title)
                .class(.navLink, .dropdownToggle)
                .href("#")
                .role(.button)
                .dataToggle(.dropdown)
                .ariaExpanded(String(false))
            Ul {
                children()
            }
            .class(.dropdownMenu)
            .ariaLabelledBy("navbarDropdown")
        }
        .class(.navItem, .dropdown)
        .add(classes, attributes, styles)
    }
}

public class NavItem: Component {
    
    let a: A
    let isListBased: Bool
    let isActive: Bool
    let isDisabled: Bool
    
    public convenience init(_ title: String, href: String, isActive: Bool = false, isDisabled: Bool = false, classes: Classes? = nil, attributes: Attributes? = nil, styles: Styles? = nil, @TagBuilder children: @escaping () -> [Tag]) {
        self.init(a: A(title).href(href),
                  isListBased: true,
                  isActive: isActive,
                  isDisabled: isDisabled,
                  classes: classes,
                  attributes: attributes,
                  styles: styles,
                  children: children)
    }
    
    public init(a: A, isListBased: Bool = true, isActive: Bool = false, isDisabled: Bool = false, classes: Classes? = nil, attributes: Attributes? = nil, styles: Styles? = nil, @TagBuilder children: @escaping () -> [Tag]) {
        self.a = a
        self.isListBased = isListBased
        self.isActive = isActive
        self.isDisabled = isDisabled
        super.init(classes, attributes, styles, children)
    }
}

extension NavItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        if isListBased {
            Li {
                a
                    .class(.navLink)
                    .class(add: .active, if: isActive)
                    .class(add: .disabled, if: isDisabled)
                    .ariaCurrent(isActive)
                children()
            }
            .class(.navItem)
            .add(classes, attributes, styles)
        } else {
            a
                .class(.navLink)
                .class(add: .active, if: isActive)
                .class(add: .disabled, if: isDisabled)
                .ariaCurrent(isActive)
                .ariaCurrent(isActive)
                .add(classes, attributes, styles)
            children()
        }
    }
}
