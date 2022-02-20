//
//  BsCssProperty.swift
//  
//
//  Created by BG on 2/19/22.
//

public enum BsCssProperty: String {
    case breadcrumbDivider = "--bs-breadcrumb-divider"
}

extension CssKeyValue {
    
    public init?(_ key: BsCssProperty, _ value: BsCssValue) {
        self.init(key, value.rawValue)
    }
    
    public init?(_ key: BsCssProperty, _ value: String) {
        self.init(key: key.rawValue, value: value)
    }
}
