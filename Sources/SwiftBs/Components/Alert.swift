//
//  Alert.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSvg

public class Alert: Component {
    
    let svg: Tag?
    let heading: String?
    let body: String?
        
    public convenience init(@TagBuilder svg: () -> Svg, heading: String? = nil, body: String? = nil, @TagBuilder _ children: @escaping () -> [Tag]) {
        self.init(svg: svg(), heading: heading, body: body, children)
    }
    
    public init(svg: Svg? = nil, heading: String? = nil, body: String? = nil, @TagBuilder _ children: @escaping () -> [Tag]) {
        self.svg = svg
        self.heading = heading
        self.body = body
        super.init() { children() }
    }
}

extension Alert: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            if let heading = heading {
                H4(heading).class(.alertHeading)
            }
            if let svg = svg {
                svg
            }
            if let body = body {
                Text(body)
            }
            children()
        }
        .class(.alert)
        .role(.alert)
        .class(add: .dFlex, .alignItemsCenter, if: svg != nil)
        .add(classes, attributes, styles)
    }
}
