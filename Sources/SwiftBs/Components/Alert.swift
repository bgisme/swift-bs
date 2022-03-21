//
//  Alert.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSvg

public class Alert: Component {
        
    /**
     Initialize an Alert
     
     - parameters:
        - isAlignedCenter: items aligned on center (useful for Img and text contents)
        - contents: Any <element>
     */
    public init(isAlignedCenter: Bool = false,
                @TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .alert)
            .class(insert: .dFlex, .alignItemsCenter, if: isAlignedCenter)
            .role(.alert)
        }
    }
}

public class AlertHeading: Component {
    
    /**
     Conveniently initialize AlertHeading
     
     - parameters:
        - text:String value of an <h4>
     */
    public convenience init(_ text: String) {
        self.init {
            H4(text)
        }
    }
    
    /**
     Initialize AlertHeading
     
     - parameters:
        - h4: Function that returns an H4
     */
    public init(_ h4: () -> H4) {
        super.init {
            h4()
                .class(insert: .alertHeading)
        }
    }
}
