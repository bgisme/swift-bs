//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
    let div: Div
    
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div {
            ModalDialog( Div {
                ModalContent( Div {
                    contents()
                })
            })
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension Modal: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modal, .fade)
            .tabindex(-1)
            .ariaHidden(true)
    }
}

public class ModalDialog: Component {
    
    let div: Div
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension ModalDialog: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalDialog)
    }
}

public class ModalContent: Component {
    
    let div: Div
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension ModalContent: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .modalContent)
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
    }
}

public class ModalFooter: Component {
    
    let div: Div
    
    public convenience init(isCloseable: Bool, other: BsButton...) {
        let closeButton = BsButton.button("Close")
            .build()
            .class(add: .bgSecondary)
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
    }
}
