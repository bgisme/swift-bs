//
//  Alert.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

open class Alert: Div {
    
    public convenience init(_ text: String) {
        self.init {
            Text(text)
        }
    }
        
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .alert)
            .role(.alert)
    }
    
//    @discardableResult
//    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        if let value = value {
//            return self.class(insert: value.alertClass, if: condition)
//        } else {
//            return self.class(remove: ColorTheme.allCases.map{$0.alertClass}, condition)
//        }
//    }
//
//    @discardableResult
//    public override func alignItems(_ value: AlignItems, _ condition: Bool = true) -> Self {
//        super.alignItems(value, condition)
//        return self.class(insert: .dFlex, if: condition)
//    }
}

extension ColorTheme {
    
    public var alertClass: Utility {
        switch self {
        case .primary:
            return .alertPrimary
        case .secondary:
            return .alertSecondary
        case .success:
            return .alertSuccess
        case .danger:
            return .alertDanger
        case .warning:
            return .alertWarning
        case .info:
            return .alertInfo
        case .light:
            return .alertLight
        case .dark:
            return .alertDark
        case .white:
            return .alertLight      // No white version
        }
    }
}

open class AlertHeading: H4 {
    
    public init(_ text: String) {
        super.init([Text(text)])
    }
}
