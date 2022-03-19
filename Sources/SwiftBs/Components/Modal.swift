//
//  Modal.swift
//  
//
//  Created by Brad Gourley on 3/15/22.
//

import SwiftHtml

public class Modal: Component {
    
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
        super.init {
            div()
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
        super.init {
            div()
                .class(insert: .modalDialog)
                .class(insert: size?.rawValue, if: size != nil)
                .class(insert: .modalDialogScrollable, if: isScrollable)
                .class(insert: .modalDialogCentered, if: isCentered)
        }
    }
}

public class ModalContent: Component {
        
    public init(_ div: () -> Div) {
        super.init {
            div()
                .class(insert: .modalContent)
        }
    }
}

public class ModalHeader: Component {
        
    public convenience init(_ text: String, isCloseable: Bool = true) {
        self.init {
            Div {
                ModalTitle(text)
                if isCloseable {
                    CloseButton(dismiss: .modal)
                }
            }
        }
    }
    
    public init(_ div: () -> Div) {
        super.init {
            div()
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
            Div {
                P(text)
            }
        }
    }
    
    public init(_ div: () -> Div) {
        super.init {
            div()
                .class(insert: .modalBody)
        }
    }
}

public class ModalFooter: Component {
        
    public convenience init(isCloseable: Bool, others: BsButton...) {
        self.init {
            Div {
                if isCloseable {
                    CloseButton(dismiss: .modal)
                }
                for other in others {
                    other
                }
            }
        }
    }
    
    public init(_ div: () -> Div) {
        super.init {
            div()
                .class(insert: .modalFooter)
        }
    }
}
