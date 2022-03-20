//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
    /// contents ... see ModalDialog
    public init(id: String,
                size: ModalDialog.Size? = nil,
                isAnimated: Bool = true,
                isBackdropStatic: Bool = false,
                isScrollable: Bool = false,
                isCentered: Bool = false,
                @TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                ModalDialog(size: size,
                            isScrollable: isScrollable,
                            isCentered: isCentered) {
                    contents()
                }
            }
            .id(id)
            .ariaLabelledBy("\(id)Label")
            .class(insert: .modal)
            .class(insert: .fade, if: isAnimated)
            .tabindex(-1)
            .dataBsBackdrop(.static, isBackdropStatic)
            .dataBsKeyboard(false, isBackdropStatic)
            .ariaHidden(true)
        }
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
    public init(size: Size? = nil,
                isScrollable: Bool = false,
                isCentered: Bool = false,
                @TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                ModalContent {
                    contents()
                }
            }
            .class(insert: .modalDialog)
            .class(insert: size?.rawValue, if: size != nil)
            .class(insert: .modalDialogScrollable, if: isScrollable)
            .class(insert: .modalDialogCentered, if: isCentered)
        }
    }
}

public class ModalContent: Component {
        
    /// contents ...
    /// ModalHeader
    /// ModalTitle
    /// ModalBody
    /// ModalFooter
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .modalContent)
        }
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
    
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .modalHeader)
        }
    }
}

public class ModalTitle: Component {
        
    public convenience init(_ text: String) {
        self.init {
            H5(text)
        }
    }
    
    public init(_ h5: () -> H5) {
        super.init {
            h5()
                .class(insert: .modalTitle)
        }
    }
}

public class ModalBody: Component {
        
    public convenience init(_ text: String) {
        self.init {
            P(text)
        }
    }
    
    /// contents ... anything
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .modalBody)
        }
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
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .modalFooter)
        }
    }
}
