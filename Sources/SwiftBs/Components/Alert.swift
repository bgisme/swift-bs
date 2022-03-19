//
//  Alert.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSvg

public class Alert: Component {
        
    /// children ... Img, AlertHeading, Any
    /// use isAlignCenter to align Img and other children
    public init(isAlignedCenter: Bool = false, div: () -> Div) {
        super.init {
            div()
                .class(insert: .alert)
                .class(insert: .dFlex, .alignItemsCenter, if: isAlignedCenter)
                .role(.alert)
        }
    }
}

public class AlertHeading: Component {
    
    public init(_ h4: () -> H4) {
        super.init {
            h4()
                .class(insert: .alertHeading)
        }
    }
}
