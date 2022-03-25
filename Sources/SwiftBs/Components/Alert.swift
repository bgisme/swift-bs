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
        - color: Bootstrap style (.primary, .secondary, etc)
     
     */
    public convenience init(_ text: String) {
        self.init(Div(text))
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
     init(_ text: String, color: Color?)
     ````

     */
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .alert)
            .role(.alert)

        super.init(div)
    }
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            self.class(insert: value.alertClass)
        } else {
            self.tag.class(remove: ColorTheme.allCases.map{$0.alertClass})
        }
        return self
    }
    
    @discardableResult
    public func alignItems(_ value: AlignItems?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            self.class(insert: .dFlex, value.class)
        } else {
            self.tag.class(remove: AlignItems.allCases.map{$0.class})
            self.tag.class(remove: .dFlex)
        }
        return self
    }
}

extension ColorTheme {
    
    public var alertClass: BsClass {
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
        self.init(H4(text))
    }
    
    /**
     Initialize AlertHeading
     
     - parameters:
        - h4: Function that returns H4
     */
    public init(_ h4: H4) {
        h4
            .class(insert: .alertHeading)

        super.init(h4)
    }
}
