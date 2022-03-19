//
//  Progress.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Progress: Component {
    
    public init(div: () -> Div) {
        super.init {
            div()
                .class(insert: .progress)
        }
    }
}

public class Progressbar: Component {
    
    public convenience init(percent: Int,
                            label: String? = nil,
                            height pixels: Int? = nil,
                            color: BgColor? = nil,
                            isStriped: Bool = false,
                            isAnimated: Bool = false) {
        self.init(percent: percent,
                  height: pixels,
                  color: color,
                  isStriped: isStriped,
                  isAnimated: isAnimated) {
            Div(label ?? "")
        }
    }
    
    /// percent > 100 becomes 100
    /// Div with text value appears as label
    public init(percent: Int,
                height pixels: Int? = nil,
                color: BgColor? = nil,
                isStriped: Bool = false,
                isAnimated: Bool = false,
                div: () -> Div) {
        let percent = percent <= 100 ? percent : 100
        super.init {
            div()
                .class(insert: .progressbar)
                .role(.progressbar)
                .style(set: .width("\(percent)%"))
                .ariaValuenow("\(percent)")
                .ariaValuemin("0")
                .ariaValuemax("100")
                .class(insert: color?.class)
                .style(set: .height("\(pixels ?? 0)"), if: pixels != nil)
        }
    }
}

