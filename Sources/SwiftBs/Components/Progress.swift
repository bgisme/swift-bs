//
//  Progress.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Progress: Component {
    
    public convenience init(progressBar: () -> Progressbar) {
        let div = Div { progressBar() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .progress)
        
        super.init(div)
    }
}

public class Progressbar: Component {
    
    /// percent > 100 becomes 100
    public convenience init(label: String, height pixels: Int? = nil) {
        let div = Div {
            if let label = label {
                Text(label)
            }
        }
        self.init(height: pixels, div)
    }
    
    public init(height pixels: Int?, _ div: Div) {
        let pixels = pixels != nil ? "\(pixels!)" : nil
        div
            .class(insert: .progressbar)
            .role(.progressbar)
            .ariaValuemin("0")
            .ariaValuemax("100")
            .style(set: .height(pixels))
        
        super.init(div)
    }
    
    @discardableResult
    public func percent(_ value: Double, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        let percent = value <= 100 ? value : 100
        tag
            .style(set: .width("\(percent)%"))
            .ariaValuenow("\(percent)")
        return self
    }
    
    @discardableResult
    public func isStriped(if condition: Bool = true) -> Self {
        tag
            .class(insert: .progressBarStriped, if: condition)
        return self
    }
    
    @discardableResult
    public func isAnimated(if condition: Bool = true) -> Self {
        tag
            .class(insert: .progressBarAnimated, if: condition)
        return self
    }
}
