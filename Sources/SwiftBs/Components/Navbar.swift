//
//  File.swift
//  
//
//  Created by BG on 2/12/22.
//

import SwiftHtml
import SwiftSgml

public class Navbar: Component {
    
    var isListBased: Bool
    var brand: () -> [Tag]
    let items: () -> [Tag]

    public init(isListBased: Bool = true, @TagBuilder brand: @escaping () -> [Tag], @TagBuilder items: @escaping () -> [Tag]) {
        self.isListBased = isListBased
        self.brand = brand
        self.items = items
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
                .dataBsToggle(.collapse)
                .dataTarget(.navbarSupportedContent)
                .ariaControls(.navbarSupportedContent)
                .ariaExpanded(false)
                .ariaLabelledBy("Toggle navigation")
                
                Div {
                    if isListBased {
                        Ul() {
                            items()
                        }
                        .class(.navbarNav)
                    } else {
                        items()
                    }
                }
                .class(add: .collapse, .navbarCollapse)
                .id("navbarSupportedContent")
            }
            .class(.containerFluid)
        }
        .class(.navbar)
        .addClassesStyles(self)
    }
}

public class NavbarBrand: Component {
    
    let img: Img?
    let text: String?
    let href: String?
    
    public convenience init(_ text: String, href: String? = nil) {
        self.init(img: nil, text: text, href: href)
    }
    
    public convenience init(_ img: Img, href: String? = nil) {
        self.init(img: img, text: nil, href: href)
    }
    
    public convenience init(_ img: Img, text: String, href: String? = nil) {
        self.init(img: img, text: text, href: href)
    }
    
    internal required init(img: Img?, text: String?, href: String?) {
        self.img = img
        self.text = text
        self.href = href
    }
}

extension NavbarBrand: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        A {
            if let img = img {
                img
                    .width(30)
                    .height(24)
            }
            if let text = text {
                Text(text)
            }
        }
        .class(.navbarBrand)
        .hrefOptional(href)
        .class(add: .h1, .mb0, if: href == nil)
        .class(add: .dInlineBlock, .alignTextTop, if: img != nil && text != nil)    // align image and text
        .addClassesStyles(self)
    }
}

public class NavDropdown: Component {
    
    let title: String
    let items: () -> [Tag]
    
    public init(_ title: String, @TagBuilder items: @escaping () -> [Tag]) {
        self.title = title
        self.items = items
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
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
            Ul {
                items()
            }
            .class(.dropdownMenu)
            .ariaLabelledBy("navbarDropdown")
        }
        .class(.navItem, .dropdown)
        .addClassesStyles(self)
    }
}

public class NavItem: Component {
    
    let a: A
    let isListBased: Bool
    let isActive: Bool
    let isDisabled: Bool
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(a: A(title).href(href),
                  isListBased: true,
                  isActive: isActive,
                  isDisabled: isDisabled)
    }
    
    public init(a: A,
                isListBased: Bool = true,
                isActive: Bool = false,
                isDisabled: Bool = false) {
        self.a = a
        self.isListBased = isListBased
        self.isActive = isActive
        self.isDisabled = isDisabled
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
            }
            .class(.navItem)
            .addClassesStyles(self)
        } else {
            a
                .class(.navLink)
                .class(add: .active, if: isActive)
                .class(add: .disabled, if: isDisabled)
                .ariaCurrent(isActive)
                .ariaCurrent(isActive)
                .addClassesStyles(self)
        }
    }
}
