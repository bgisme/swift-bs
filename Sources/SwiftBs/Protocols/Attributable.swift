//
//  Attributable.swift
//
//
//  Created by BG on 2/19/22.
//

public protocol Attributable {
    
    func value(_ key: AttributeKey) -> String?
    
    func attribute(_ key: AttributeKey, _ value: String?, _ condition: Bool) -> Self
    
    func delete(_ key: AttributeKey) -> Self
}
