//
//  Bootstrapable.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

public protocol Bootstrapable {
    
    func `class`(insert classes: BsClass?..., if condition: Bool) -> Self
    
    func `class`(insert classes: [BsClass]?, _ condition: Bool) -> Self
    
    func style(set styles: CssKeyValue?..., if condition: Bool) -> Self
    
    func style(set styles: [CssKeyValue]?, _ condition: Bool) -> Self
}
