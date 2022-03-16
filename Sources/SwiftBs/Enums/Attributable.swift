//
//  Attributable.swift
//
//
//  Created by BG on 2/19/22.
//

public protocol Attributable {
    
    func value(_ key: AttributeKey) -> String?
    
    func attribute(_ key: AttributeKey, _ value: String?) -> Self
    
    func delete(_ key: AttributeKey) -> Self
    
}
 
public protocol AttributeValuable {
    
    typealias Key = String
    typealias Value = String
    
    func attr(_ key: AttributeKey, _ value: String?, _ condition: Bool) -> Self
        
    func attrFlag(_ key: AttributeKey, _ condition: Bool) -> Self
    
    func `class`(add classes: BsClass?..., if condition: Bool) -> Self
    
    func `class`(add classes: [BsClass]?, _ condition: Bool) -> Self
    
    func style(add styles: CssKeyValue?..., if condition: Bool) -> Self
    
    func style(add styles: [CssKeyValue]?, _ condition: Bool) -> Self
    
    func style(add styles: [(Key, Value)]?, _ condition: Bool) -> Self
}

public enum AttributeKey: String {
    /// String Attributes
    case ariaControls = "aria-controls"
    case ariaCurrent = "aria-current"
    case ariaDescribedby = "aria-describedby"
    case ariaDisabled = "aria-disabled"
    case ariaLabel = "aria-label"
    case ariaLabelledBy = "aria-labelledby"
    case `class`
    case dataParent = "data-bs-parent"
    case dataBsBackdrop = "data-bs-backdrop"
    case dataBsDisplay = "data-bs-display"
    case dataBsDismiss = "data-bs-dismiss"
    case dataBsRide = "data-bs-ride"
    case dataBsSlide = "data-bs-slide"
    case dataBsSlideTo = "data-bs-slide-to"
    case dataBsTarget = "data-bs-target"
    case dataBsToggle = "data-bs-toggle"
    case disabled = "disabled"
    case grid
    case id
    case list
    case max
    case min
    case role
    case size
    case step
    case style
    case toolbar
    case type
    /// Bool Attributes
    case ariaExpanded = "aria-expanded"
    case ariaHaspopup = "aria-haspopup"
    case ariaHidden = "aria-hidden"
    case ariaPressed = "aria-pressed"
    case autoComplete = "auto-complete"
    case dataBsInterval = "data-bs-interval"
    case dataBsKeyboard = "data-bs-keyboard"
    case dataBsTouch = "data-bs-touch"
    /// Flag Attributes
    case checked
    case multiple
    case readonly
    case selected
}

public enum AttributeValuePrefix: String {
    case hash = "#"
    case dot = "."
}
