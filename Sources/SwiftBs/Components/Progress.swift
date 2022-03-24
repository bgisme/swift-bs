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
                            theme: ColorTheme? = nil,
                            isStriped: Bool = false,
                            isAnimated: Bool = false) {
        self.init {
            Progressbar(percent: percent,
                        label: label,
                        height: pixels,
                        theme: theme,
                        isStriped: isStriped,
                        isAnimated: isAnimated) {}
        }
    }
    
    /// contents ... Progressbar
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .progress)
        
        super.init(div)
    }
}

public class Progressbar: Component {
    
    public convenience init(percent: Int,
                            label: String? = nil,
                            height pixels: Int? = nil,
                            theme: ColorTheme? = nil,
                            isStriped: Bool = false,
                            isAnimated: Bool = false) {
        self.init(percent: percent,
                  label: label,
                  height: pixels,
                  theme: theme,
                  isStriped: isStriped,
                  isAnimated: isAnimated,
                  contents: {})
    }
    
    /// percent > 100 becomes 100
    /// contents ... anything (usually nothing)
    public convenience init(percent: Int,
                            label: String? = nil,
                            height pixels: Int? = nil,
                            theme: ColorTheme? = nil,
                            isStriped: Bool = false,
                            isAnimated: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            if let label = label {
                Text(label)
            }
            contents()
        }
        self.init(percent: percent,
                  height: pixels,
                  theme: theme,
                  isStriped: isStriped,
                  isAnimated: isAnimated,
                  div)
    }
    
    public init(percent: Int,
                height pixels: Int?,
                theme: ColorTheme?,
                isStriped: Bool,
                isAnimated: Bool,
                _ div: Div) {
        let percent = percent <= 100 ? percent : 100
        let pixels = pixels != nil ? "\(pixels!)" : nil
        div
            .class(insert: .progressbar)
            .role(.progressbar)
            .style(set: .width("\(percent)%"))
            .ariaValuenow("\(percent)")
            .ariaValuemin("0")
            .ariaValuemax("100")
            .class(insert: theme?.backgroundClass)
            .style(set: .height(pixels))
        
        super.init(div)
    }
}

