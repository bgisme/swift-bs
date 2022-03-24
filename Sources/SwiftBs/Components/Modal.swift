//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
    /// contents ... see ModalContent
    public convenience init(id: String,
                            size: ModalDialog.Size? = nil,
                            isAnimated: Bool = true,
                            isBackdropStatic: Bool = false,
                            isScrollable: Bool = false,
                            isCentered: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        self.init(id: id,
                  isAnimated: isAnimated,
                  isBackdropStatic: isBackdropStatic) {
            ModalDialog(size: size,
                        isScrollable: isScrollable,
                        isCentered: isCentered) {
                contents()
            }
        }
    }
    
    public convenience init(id: String,
                            isAnimated: Bool = true,
                            isBackdropStatic: Bool = false,
                            dialog: () -> ModalDialog) {
        let div = Div { dialog() }
        self.init(id: id, isAnimated: isAnimated, isBackdropStatic: isBackdropStatic, div)
    }
    
    public init(id: String,
                isAnimated: Bool = true,
                isBackdropStatic: Bool = false,
                _ div: Div) {
        div
            .id(id)
            .ariaLabelledBy("\(id)Label")
            .class(insert: .modal)
            .class(insert: .fade, if: isAnimated)
            .tabindex(-1)
            .dataBsBackdrop(.static, isBackdropStatic)
            .dataBsKeyboard(false, isBackdropStatic)
            .ariaHidden(true)
        
        super.init(div)
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
        
    /// contents ... see ModalContent
    public convenience init(size: Size? = nil,
                            isScrollable: Bool = false,
                            isCentered: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            ModalContent {
                contents()
            }
        }
        self.init(size: size, isScrollable: isScrollable, isCentered: isCentered, div)
    }
    
    public init(size: Size? = nil,
                isScrollable: Bool = false,
                isCentered: Bool = false,
                _ div: Div) {
        div
            .class(insert: .modalDialog)
            .class(insert: size?.rawValue, if: size != nil)
            .class(insert: .modalDialogScrollable, if: isScrollable)
            .class(insert: .modalDialogCentered, if: isCentered)
        
        super.init(div)
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
                    CloseButton(dismiss: .modal)
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
