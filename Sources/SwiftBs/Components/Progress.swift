
import SwiftHtml

open class Progress: Div {
        
    public convenience init(progressBar: () -> Progressbar) {
        self.init(content: progressBar)
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .progress)
    }
}

open class Progressbar: Div {
        
    /// percent > 100 becomes 100
    public convenience init(label: String, height pixels: Int? = nil) {
        self.init(height: pixels) { Text(label) }
    }
    
    public init(height pixels: Int?,
                @TagBuilder content: () -> Tag) {
        let pixels = pixels != nil ? "\(pixels!)" : nil
        super.init([content()])
        self
            .class(insert: .progressbar)
            .role(.progressbar)
            .ariaValuemin("0")
            .ariaValuemax("100")
            .style(set: .height(pixels))
    }
}

extension Progressbar {
    
    @discardableResult
    public func percent(_ value: Double, _ condition: Bool = true) -> Self {
        let percent = value <= 100 ? value : 100
        return self
            .style(set: .width("\(percent)%"), if: condition)
            .ariaValuenow("\(percent)", condition)
    }
    
    @discardableResult
    public func isStriped(if condition: Bool = true) -> Self {
        self
            .class(insert: .progressBarStriped, if: condition)
    }
    
    @discardableResult
    public func isAnimated(if condition: Bool = true) -> Self {
        self
            .class(insert: .progressBarAnimated, if: condition)
    }
}
