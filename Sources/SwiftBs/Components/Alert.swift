//
//  Alert.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSvg

public class Alert: Component {
    
    let svg: Svg?
    let div: Div
    
    public convenience init(_ text: String) {
        self.init(svg: nil, Div(text))
    }
    
    public convenience init(_ svg: Svg, text: String) {
        self.init(svg: svg, Div(text))
    }
    
    public init(svg: Svg? = nil, _ div: Div) {
        self.svg = svg
        self.div = div
    }
}

extension Alert: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        if let svg = svg {
            Div {
                svg
                div
            }
            .class(.alert)
            .role(.alert)
            .class(add: .dFlex, .alignItemsCenter)
            .addClassesStyles(self)
        } else {
            div
                .class(.alert)
                .role(.alert)
                .addClassesStyles(self)
        }
    }
}

public class AlertHeading: Component {
    
    let h4: H4
    
    public convenience init(_ text: String) {
        self.init(H4(text))
    }
    
    public init(_ h4: H4) {
        self.h4 = h4
    }
}

extension AlertHeading: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        h4
            .class(.alertHeading)
            .addClassesStyles(self)
    }
}
