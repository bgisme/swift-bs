//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    enum `Type` {
        case button
        case input(type: Input.`Type`)
        case link(rel: A.Rel, href: String)
    }
    
    var title: String?
    private var type: `Type` = .button
    private var isToggle: Bool = false
    private var isPressed: Bool = false
    private var isDisabled: Bool = false
    private var isActive: Bool = false
    
    internal required init(_ type: Type) {
        self.type = type
        super.init {}
    }
    
    public static func button(title: String? = nil, @TagBuilder _ children: @escaping () -> [Tag]) -> Self {
        let button = Self.init(.button)
        button.children(children)
        button.title = title
        return button
    }
    
    public static func input(_ type: Input.`Type`) -> Self {
        Self.init(.input(type: type))
    }
    
    public static func link(_ rel: A.Rel, href: String) -> Self {
        Self.init(.link(rel: rel, href: href))
    }
    
    @discardableResult
    public func toggles(_ value: Bool, isPressed: Bool = false, if condition: Bool = true) -> Self {
        guard condition else { return self }
        self.isToggle = value
        self.isPressed = isPressed
        return self
    }
    
    @discardableResult
    public func isDisabled(_ value: Bool, if condition: Bool = true) -> Self {
        guard condition else { return self }
        self.isDisabled = value
        return self
    }
}

extension BsButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        switch type {
        case .button:
            Button {
                if let title = title {
                    Text(title)
                }
                children()
            }
            .class(.btn)
            .type(.button)
            .class(add: .active, if: isToggle && isPressed)
            .dataToggle(.button, isToggle)
            .disabled(isDisabled)
            .ariaPressed(isPressed, isToggle && isPressed)
            .autoComplete(false, isToggle && isPressed)
            .add(classes, attributes, styles)
        case .input(let type):
            Input()
            .class(.btn)
            .type(type)
            .value(title ?? "")
            .add(classes, attributes, styles)
        case .link(let rel, let href):
            A {
                if let title = title {
                    Text(title)
                }
                children()
            }
            .rel(rel)
            .class(isDisabled ? [.btn, .disabled] : [.btn])
            .role(.button)
            .href(href)
            .class(add: .active, if: isActive)
            .ariaPressed(true, isActive)
            .ariaDisabled(true, isDisabled)
            .add(classes, attributes, styles)
        }
    }
}

//public class BsButton: Component {
//
//    let text: String?
//    let isToggle: Bool
//    let isPressed: Bool
//    let isDisabled: Bool
//
//    public init(_ text: String? = nil,
//                isToggle: Bool = false,
//                isPressed: Bool = false,
//                isDisabled: Bool = false,
//                @TagBuilder children: @escaping () -> [Tag]) {
//        self.text = text
//        self.isToggle = isToggle
//        self.isPressed = isPressed
//        self.isDisabled = isDisabled
//        super.init() { children() }
//    }
//}
//
//extension BsButton: TagRepresentable {
//
//    @TagBuilder
//    public func build() -> Tag {
//        Button {
//            if let text = text {
//                Text(text)
//            }
//            children()
//        }
//        .class(.btn)
//        .type(.button)
//        .class(add: .active, if: isToggle && isPressed)
//        .dataToggle(.button, isToggle)
//        .disabled(isDisabled)
//        .ariaPressed(isPressed, isToggle && isPressed)
//        .autoComplete(false, isToggle && isPressed)
//        .add(classes, attributes, styles)
//    }
//}

//public class BsButtonInput: Component {
//    let text: String
//    let `type`: Input.`Type`
//
//    public init(_ text: String, type: Input.`Type`) {
//        self.text = text
//        self.type = type
//        super.init() { }
//    }
//}

//extension BsButtonInput: TagRepresentable {
//    @TagBuilder
//    public func build() -> Tag {
//        Input()
//        .class(.btn)
//        .type(type)
//        .value(text)
//        .add(classes, attributes, styles)
//    }
//}

//public class BsButtonLink: Component {
//    let text: String
//    let href: String
//    let isDisabled: Bool
//    let isActive: Bool
//
//    public init(_ text: String, href: String = "#", isDisabled: Bool = false, isActive: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
//        self.text = text
//        self.href = href
//        self.isDisabled = isDisabled
//        self.isActive = isActive
//        super.init() { children() }
//    }
//}
//
//extension BsButtonLink: TagRepresentable {
//
//    @TagBuilder
//    public func build() -> Tag {
//        A {
//            Text(text)
//            children()
//        }
//        .class(isDisabled ? [.btn, .disabled] : [.btn])
//        .role(.button)
//        .href(href)
//        .class(add: .active, if: isActive)
//        .ariaPressed(true, isActive)
//        .ariaDisabled(true, isDisabled)
//        .add(classes, attributes, styles)
//    }
//}
