//
//  Alert.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSgml

public class Alert: Component {
    
    let div: Div
    let hasIcon: Bool
    
    public init(_ div: Div, hasIcon: Bool = false) {
        self.div = div
        self.hasIcon = hasIcon
    }
}

extension Alert: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(.alert)
            .role(.alert)
            .class(add: .dFlex, .alignItemsCenter, if: hasIcon)
            .class(add: bsClasses)
    }
}

public class AlertHeading: Component {
    
    let h4: H4
    
    public init(_ h4: H4) {
        self.h4 = h4
    }
}

extension AlertHeading: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        h4
            .class(.alertHeading)
    }
}
