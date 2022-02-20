//
//  Attribute+Type.swift
//  
//
//  Created by BG on 2/19/22.
//

import SwiftHtml

extension Attribute {
    
    static let `type` = "type"
    
    public enum `Type`: String {
        case a
        case button
        case embed
        case input
        case link
        case menu
        case object
        case script
        case source
        case style
    }
}
