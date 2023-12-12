
import SwiftHtml

open class Modal: Div {
    
    public init(id: String, dialog: () -> ModalDialog) {
        super.init([dialog()])
        self
            .id(id)
            .ariaLabelledBy("\(id)Label")
            .class(insert: .modal)
            .tabindex(-1)
            .ariaHidden(true)
    }
    
    @discardableResult
    public func isFadable(if condition: Bool = true) -> Self {
        self.class(insert: .fade, if: condition)
    }
    
    /// clicking outside modal does not dismiss it
    @discardableResult
    public func isBackdropStatic(if condition: Bool = true) -> Self {
        self
            .dataBsBackdrop(.static, condition)
            .dataBsKeyboard(false, condition)
    }
}

open class ModalDialog: Div {
    
    public init(content: () -> ModalContent) {
        super.init([content()])
        self
            .class(insert: .modalDialog)
    }
    
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
        
        var `class`: Utility {
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
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        self.class(insert: value.class, if: condition)
    }
    
    @discardableResult
    public func isScrollable(if condition: Bool = true) -> Self {
        self.class(insert: .modalDialogScrollable, if: condition)
    }
    
    @discardableResult
    public func isCentered(if condition: Bool = true) -> Self {
        self.class(insert: .modalDialogCentered, if: condition)
    }
}

open class ModalContent: Div {
    
    /// contents... ModalHeader, ModalTitle, ModalBody, ModalFooter
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .modalContent)
    }
}

open class ModalHeader: Div {
            
    public convenience init(_ text: String, isCloseable: Bool = true) {
        self.init {
            ModalTitle(text)
            if isCloseable {
                CloseButton(dismiss: .modal)
            }
        }
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .modalHeader)
    }
}

open class ModalTitle: H5 {
        
    public convenience init(_ text: String) {
        self.init { Text(text) }
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .modalTitle)
    }
}

open class ModalBody: Div {

    public convenience init(_ text: String) {
        self.init { P(text) }
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .modalBody)
    }
}

open class ModalFooter: Div {
    
    public convenience init(isCloseable: Bool, others: BsButton...) {
        self.init {
            if isCloseable {
                BsButton(.button(isToggle: false, isPressed: false)) {
                    Button("Close").dataBsDismiss(.modal)
                }
                .border(.secondary)
            }
            for other in others {
                other
            }
        }
    }
        
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .modalFooter)
    }
}
