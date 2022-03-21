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
     Initialize Alert with text
     
     - parameters:
        - text: String to appear in Alert
     
     */
    public convenience init(_ text: String) {
        self.init {
            Div(text)
        }
    }
        
    /**
     Initialize an Alert with any combination of Tag classes.
          
     - parameters:
        - isAlignedCenter: Contents aligned on center. Useful when combining elements of different heights.
        - contents: Any <element>
     
     ## Examples
     ````swift
     Alert {
        Text("A line of text in the middle of the Alert.")
     }
     ````
     
     Will make the HTML ...
     
     ````html
     <div class="alert" role="alert">
        A line of text in the middle of the Alert.
     </div>
     ````
     Combining elements with different heights ...
     ````swift
     Alert(isAlignedCenter: true) {
        Svg(...)
        Div("Some text to the right of the icon.")
     }
     ````
     Will make the HTML ...
     ````html
     <div class="alert">
        <svg>
        <div>A line of text in the middle of the Alert.</div>
     </div>
     ````
     
     ## Discussion
     
     If you want a Bootstrap styled heading, use an `AlertHeading`
     
     If you just want text, use the convenience initializer
     ````swift
     init(_ text: String)
     ````

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
     Initialize AlertHeading with text
     
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
        - h4: Function that returns H4
     */
    public init(_ h4: () -> H4) {
        super.init {
            h4()
                .class(insert: .alertHeading)
        }
    }
}
