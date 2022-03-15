//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
    let div: Div
    let isBackdropStatic: Bool
    let isCentered: Bool
    
    public convenience init(id: String,
                            isBackdropStatic: Bool = false,
                            isScrollable: Bool = false,
                            isCentered: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            ModalDialog(isScrollable: isScrollable) { contents() }
        }
            .id(id)
            .ariaLabelledBy("\(id)Label")
        self.init(div, isBackdropStatic: isBackdropStatic, isCentered: isCentered)
    }
    
    public init(_ div: Div,
                isBackdropStatic: Bool = false,
                isCentered: Bool = false) {
        self.div = div
        self.isBackdropStatic = isBackdropStatic
        self.isCentered = isCentered
    }
}

extension Modal: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modal, .fade)
            .tabindex(-1)
            .dataBsBackdrop(.static, isBackdropStatic)
            .dataBsKeyboard(false, isBackdropStatic)
            .class(add: .modalDialogCentered, if: isCentered)
            .ariaHidden(true)
            .addClassesStyles(self)
    }
}

public class ModalDialog: Component {
    
    let div: Div
    let isScrollable: Bool
    
    public convenience init(isScrollable: Bool = false,
                            @TagBuilder content: () -> [Tag]) {
        let div = Div { ModalContent { content() } }
        self.init(div, isScrollable: isScrollable)
    }
    
    public init(_ div: Div, isScrollable: Bool = false) {
        self.div = div
        self.isScrollable = isScrollable
    }
}

extension ModalDialog: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalDialog)
            .class(add: .modalDialogScrollable)
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
