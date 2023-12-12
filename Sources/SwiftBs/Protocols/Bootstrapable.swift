
public protocol Bootstrapable {
    
    func `class`(insert classes: Utility?..., if condition: Bool) -> Self
    
    func `class`(insert classes: [Utility]?, _ condition: Bool) -> Self
    
    func `class`(remove classes: Set<Utility>?, _ condition: Bool) -> Self
    
    func style(set styles: CssKeyValue?..., if condition: Bool) -> Self
    
    func style(set styles: [CssKeyValue]?, _ condition: Bool) -> Self
}
