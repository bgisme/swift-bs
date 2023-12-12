
public protocol AttributeValuable {
    
    typealias Key = String
    typealias Value = String
    
    func attribute(_ key: AttributeKey, _ value: String?, _ condition: Bool) -> Self
        
    func attributeFlag(_ key: AttributeKey, _ condition: Bool) -> Self
    
    func `class`(insert classes: Utility?..., if condition: Bool) -> Self
    
    func `class`(insert classes: [Utility]?, _ condition: Bool) -> Self
    
    func `class`(remove classes: [Utility]?, _ condition: Bool) -> Self
    
    func style(set styles: CssKeyValue?..., if condition: Bool) -> Self
    
    func style(set styles: [CssKeyValue]?, _ condition: Bool) -> Self
    
    func style(set styles: [(Key, Value)]?, _ condition: Bool) -> Self
}
