//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
    public enum Size {
        case sm
        case lg
        case xl
        case fullscreen
        case fullscreenSmDown
        case fullscreenMdDown
        case fullscreenLgDown
        case fullscreenXlDown
        case fullscreenXxlDown
        
        var rawValue: BsClass {
            switch self {
            case .sm:
                return .modalSm
            case .lg:
                return .modalLg
            case .xl:
                return .modalXl
            case .fullscreen:
                return .modalFullscreen
            case .fullscreenSmDown:
                return .modalFullscreenSmDown
            case .fullscreenMdDown:
                return .modalFullscreenMdDown
            case .fullscreenLgDown:
                return .modalFullscreenLgDown
            case .fullscreenXlDown:
                return .modalFullscreenXlDown
            case .fullscreenXxlDown:
                return .modalFullscreenXxlDown
            }
        }
    }
    
    let div: Div
    let size: BsClass?
    let isAnimated: Bool
    let isBackdropStatic: Bool
    
    public convenience init(id: String,
                            size: Size? = nil,
                            isAnimated: Bool = true,
                            isBackdropStatic: Bool = false,
                            isScrollable: Bool = false,
                            isCentered: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            ModalDialog(isScrollable: isScrollable,
                        isCentered: isCentered) {
                contents()
            }
        }
            .id(id)
            .ariaLabelledBy("\(id)Label")
        self.init(div, isAnimated: isAnimated, isBackdropStatic: isBackdropStatic)
    }
    
    public init(_ div: Div,
                size: Size? = nil,
                isAnimated: Bool = true,
                isBackdropStatic: Bool = false) {
        self.div = div
        self.size = size?.rawValue
        self.isAnimated = isAnimated
        self.isBackdropStatic = isBackdropStatic
    }
}

extension Modal: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modal)
            .class(add: size, if: size != nil)
            .class(add: .fade, if: isAnimated)
            .tabindex(-1)
            .dataBsBackdrop(.static, isBackdropStatic)
            .dataBsKeyboard(false, isBackdropStatic)
            .ariaHidden(true)
            .addClassesStyles(self)
    }
}

public class ModalDialog: Component {
    
    let div: Div
    let isScrollable: Bool
    let isCentered: Bool
    
    public convenience init(isScrollable: Bool = false,
                            isCentered: Bool = false,
                            @TagBuilder content: () -> [Tag]) {
        let div = Div { ModalContent { content() } }
        self.init(div,
                  isScrollable: isScrollable,
                  isCentered: isCentered)
    }
    
    public init(_ div: Div,
                isScrollable: Bool = false,
                isCentered: Bool = false) {
        self.div = div
        self.isScrollable = isScrollable
        self.isCentered = isCentered
    }
}

extension ModalDialog: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalDialog)
            .class(add: .modalDialogScrollable, if: isScrollable)
            .class(add: .modalDialogCentered, if: isCentered)
            .addClassesStyles(self)
    }
}

public class ModalContent: Component {
    
    let div: Div
    
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension ModalContent: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalContent)
            .addClassesStyles(self)
    }
}

public class ModalHeader: Component {
    
    let div: Div
    
    public convenience init(_ text: String, isCloseable: Bool = true) {
        let title = ModalTitle(text)
        let closeButton = CloseButton().build()
        let div = Div {
            title
            if isCloseable {
                closeButton
                    .dataBsDismiss(.modal)
            }
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension ModalHeader: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalHeader)
            .addClassesStyles(self)
    }
}

public class ModalTitle: Component {
    
    let h5: H5
    
    public convenience init(_ text: String) {
        self.init(H5(text))
    }
    
    public init(_ h5: H5) {
        self.h5 = h5
    }
}

extension ModalTitle: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        h5
            .class(add: .modalTitle)
            .addClassesStyles(self)
    }
}

public class ModalBody: Component {
    
    let div: Div
    
    public convenience init(_ text: String) {
        let div = Div {
            P(text)
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension ModalBody: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalBody)
            .addClassesStyles(self)
    }
}

public class ModalFooter: Component {
    
    let div: Div
    
    public convenience init(isCloseable: Bool, other: BsButton...) {
        let closeButton = BsButton("Close")
            .build()
            .class(add: .btnSecondary)
            .dataBsDismiss(.modal)
        let div = Div {
            if isCloseable {
                closeButton
            }
            other.map{$0}
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension ModalFooter: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalFooter)
            .addClassesStyles(self)
    }
}
