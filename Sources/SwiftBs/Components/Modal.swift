//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
    let div: Div
    let isAnimated: Bool
    let isBackdropStatic: Bool
    
    public convenience init(id: String,
                            size: ModalDialog.Size? = nil,
                            isAnimated: Bool = true,
                            isBackdropStatic: Bool = false,
                            isScrollable: Bool = false,
                            isCentered: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        self.init(isAnimated: isAnimated, isBackdropStatic: isBackdropStatic) {
            Div {
                ModalDialog(size: size,
                            isScrollable: isScrollable,
                            isCentered: isCentered) {
                    contents()
                }
            }
            .id(id)
            .ariaLabelledBy("\(id)Label")
        }
    }
    
    public init(isAnimated: Bool = true,
                isBackdropStatic: Bool = false,
                div: () -> Div) {
        self.isAnimated = isAnimated
        self.isBackdropStatic = isBackdropStatic
        self.div = div()
    }
}

extension Modal: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modal)
            .class(add: .fade, if: isAnimated)
            .tabindex(-1)
            .dataBsBackdrop(.static, isBackdropStatic)
            .dataBsKeyboard(false, isBackdropStatic)
            .ariaHidden(true)
            .merge(attributes)
    }
}

public class ModalDialog: Component {
    
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
    let isScrollable: Bool
    let isCentered: Bool
    
    public convenience init(size: Size? = nil,
                            isScrollable: Bool = false,
                            isCentered: Bool = false,
                            @TagBuilder content: () -> [Tag]) {
        self.init(size: size, isScrollable: isScrollable, isCentered: isCentered, div: {
            Div {
                ModalContent {
                    Div {
                        content()
                    }
                }
            }
        })
    }
    
    public init(size: Size? = nil,
                isScrollable: Bool = false,
                isCentered: Bool = false,
                div: () -> Div) {
        self.size = size?.rawValue
        self.isScrollable = isScrollable
        self.isCentered = isCentered
        self.div = div()
    }
}

extension ModalDialog: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalDialog)
            .class(add: size, if: size != nil)
            .class(add: .modalDialogScrollable, if: isScrollable)
            .class(add: .modalDialogCentered, if: isCentered)
            .merge(attributes)
    }
}

public class ModalContent: Component {
    
    let div: Div
    
    public init(_ div: () -> Div) {
        self.div = div()
    }
}

extension ModalContent: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalContent)
            .merge(attributes)
    }
}

public class ModalHeader: Component {
    
    let div: Div
    
    public convenience init(_ text: String, isCloseable: Bool = true) {
        self.init {
            Div {
                ModalTitle(text)
                if isCloseable {
                    CloseButton()
                        .dataBsDismiss(.modal)
                }
            }
        }
    }
    
    public init(_ div: () -> Div) {
        self.div = div()
    }
}

extension ModalHeader: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalHeader)
            .merge(attributes)
    }
}

public class ModalTitle: Component {
    
    let h5: H5
    
    public convenience init(_ text: String) {
        self.init {
            H5(text)
        }
    }
    
    public init(_ h5: () -> H5) {
        self.h5 = h5()
    }
}

extension ModalTitle: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        h5
            .class(add: .modalTitle)
            .merge(attributes)
    }
}

public class ModalBody: Component {
    
    let div: Div
    
    public convenience init(_ text: String) {
        self.init {
            Div {
                P(text)
            }
        }
    }
    
    public init(_ div: () -> Div) {
        self.div = div()
    }
}

extension ModalBody: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalBody)
            .merge(attributes)
    }
}

public class ModalFooter: Component {
    
    let div: Div
    
    public convenience init(isCloseable: Bool, others: BsButton...) {
        self.init {
            Div {
                if isCloseable {
                    BsButton {
                        Button("Close")
                            .class(add: .btnSecondary)
                            .dataBsDismiss(.modal)
                    }
                }
                for other in others {
                    other
                }
            }
        }
    }
    
    public init(_ div: () -> Div) {
        self.div = div()
    }
}

extension ModalFooter: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalFooter)
            .merge(attributes)
    }
}
