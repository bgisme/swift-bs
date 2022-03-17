//
//  AttributeValuable.swift
//  
//
//  Created by Brad Gourley on 3/17/22.
//

public protocol AttributeValuable {
    
    typealias Key = String
    typealias Value = String
    
    func attr(_ key: AttributeKey, _ value: String?, _ condition: Bool) -> Self
        
    func attrFlag(_ key: AttributeKey, _ condition: Bool) -> Self
    
    func `class`(add classes: BsClass?..., if condition: Bool) -> Self
    
    func `class`(add classes: [BsClass]?, _ condition: Bool) -> Self
    
    func style(add styles: CssKeyValue?..., if condition: Bool) -> Self
    
    func style(add styles: [CssKeyValue]?, _ condition: Bool) -> Self
    
    func style(add styles: [(Key, Value)]?, _ condition: Bool) -> Self
}
