//
//  Card.swift
//  
//
//  Created by Brad Gourley on 3/4/22.
//

import SwiftHtml
import SwiftSgml

public class Card: Component {
    
    let div: Div
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension Card: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(.card)
    }
}

public class CardBody: Component {
    
    let div: Div
    
    public init(_ div: Div) {
        self.div = div
    }
}

public class CardTitle: Component {
    
    let h5: H5
    
    public init(_ h5: H5) {
        self.h5 = h5
    }
}

extension CardTitle: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        h5
            .class(.cardTitle)
    }
}

public class CardText: Component {
    
    let p: P
    
    public init(_ p: P) {
        self.p = p
    }
}

extension CardText: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        p
            .class(.cardText)
    }
}
