//
//  Progress.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Progress: Component {
    
    public convenience init(percent: Int,
                            label: String? = nil,
                            height pixels: Int? = nil,
                            color: Color? = nil,
                            isStriped: Bool = false,
                            isAnimated: Bool = false) {
        self.init {
            Progressbar(percent: percent,
                        label: label,
                        height: pixels,
                        color: color,
                        isStriped: isStriped,
                        isAnimated: isAnimated) {}
        }
    }
    
    /// contents ... Progressbar
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .progress)
        }
    }
}

public class Progressbar: Component {
    
    public convenience init(percent: Int,
                            label: String? = nil,
                            height pixels: Int? = nil,
                            color: Color? = nil,
                            isStriped: Bool = false,
                            isAnimated: Bool = false) {
        self.init(percent: percent,
                  label: label,
                  height: pixels,
                  color: color,
                  isStriped: isStriped,
                  isAnimated: isAnimated,
                  contents: {})
    }
    
    /// percent > 100 becomes 100
    /// contents ... anything (usually nothing)
    public init(percent: Int,
                label: String? = nil,
                height pixels: Int? = nil,
                color: Color? = nil,
                isStriped: Bool = false,
                isAnimated: Bool = false,
                @TagBuilder contents: () -> [Tag]) {
        let percent = percent <= 100 ? percent : 100
        super.init {
            Div {
                if let label = label {
                    Text(label)
                }
                contents()
            }            .class(insert: .progressbar)
            .role(.progressbar)
            .style(set: .width("\(percent)%"))
            .ariaValuenow("\(percent)")
            .ariaValuemin("0")
            .ariaValuemax("100")
            .class(insert: color?.backgroundClass)
            .style(set: .height("\(pixels ?? 0)"), if: pixels != nil)
        }
    }
}

