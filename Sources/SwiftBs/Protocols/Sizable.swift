//
//  Sizable.swift
//  
//
//  Created by Brad Gourley on 3/23/22.
//

public protocol Sizable {
    
    @discardableResult
    func size(_ value: Size?, _ condition: Bool) -> Self
}
