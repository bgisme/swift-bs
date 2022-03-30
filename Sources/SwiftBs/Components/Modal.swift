//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
    public convenience init(id: String, dialog: () -> ModalDialog) {
        let div = Div { dialog() }
        self.init(id: id, div)
    }
    
    public init(id: String, _ div: Div) {
        div
            .id(id)
            .ariaLabelledBy("\(id)Label")
            .class(insert: .modal)
            .tabindex(-1)
            .ariaHidden(true)
        
        super.init(div)
    }
    
    @discardableResult
    public func isFadable(if condition: Bool = true) -> Self {
        tag
            .class(insert: .fade, if: condition)
        return self
    }
    
    /// clicking outside modal does not dismiss it
    @discardableResult
    public func isBackdropStatic(if condition: Bool = true) -> Self {
        tag
            .dataBsBackdrop(.static, condition)
            .dataBsKeyboard(false, condition)
        return self
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
        
        var rawValue: Utility {
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
        
    /// contents ... see ModalContent
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div {
            ModalContent {
                contents()
            }
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .modalDialog)
        
        super.init(div)
    }
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        tag
            .class(insert: value.rawValue, if: condition)
        return self
    }
    
    @discardableResult
    public func isScrollable(if condition: Bool = true) -> Self {
        tag
            .class(insert: .modalDialogScrollable, if: condition)
        return self
    }
    
    @discardableResult
    public func isCentered(if condition: Bool = true) -> Self {
        tag
            .class(insert: .modalDialogCentered, if: condition)
        return self
    }
}

public class ModalContent: Component {
        
    /// contents ...
    /// ModalHeader
    /// ModalTitle
    /// ModalBody
    /// ModalFooter
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .modalContent)

        super.init(div)
    }
}

public class ModalHeader: Component {
        
    public convenience init(_ text: String, isCloseable: Bool = true) {
        self.init {
            ModalTitle(text)
            if isCloseable {
                CloseButton(dismiss: .modal)
            }
        }
    }
    
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .modalHeader)
        
        super.init(div)
    }
}

public class ModalTitle: Component {
        
    public convenience init(_ text: String) {
        let h5 = H5(text)
        self.init(h5)
    }
    
    public init(_ h5: H5) {
        h5
            .class(insert: .modalTitle)
        
        super.init(h5)
    }
}

public class ModalBody: Component {
        
    public convenience init(_ text: String) {
        self.init {
            P(text)
        }
    }
    
    /// contents ... anything
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .modalBody)

        super.init(div)
    }
}

public class ModalFooter: Component {
        
    public convenience init(isCloseable: Bool, others: BsButton...) {
        self.init {
            if isCloseable {
                BsButton {
                    Button("Close").dataBsDismiss(.modal)
                }
                .border(.secondary)
            }
            for other in others {
                other
            }
        }
    }
    
    /// contents ... anything
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .modalFooter)
        
        super.init(div)
    }
}
