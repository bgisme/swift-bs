//
//  FormFloating.swift
//  
//
//  Created by Brad Gourley on 6/26/22.
//

import SwiftHtml

open class FormFloating: Div {
        
    public init(label: () -> Label, input: () -> Input) {
        let label = label()
        let input = input()
        let temp = Tag {
            label
            input
        }
        #if DEBUG
        let isFormLabel = label.classes.compactMap{ Utility(rawValue: $0) }.contains(.formLabel)
        if !isFormLabel { print("ERROR: FormFloating label is not of class .formLabel") }
        let isFormControl = input.classes.compactMap{ Utility(rawValue: $0) }.contains(.formControl)
        if !isFormControl { print("ERROR: FormFloating input is not of class .formControl") }
        #endif
        super.init(temp.children)
        self
            .class(insert: .formFloating)
    }
    
//    public convenience init(label: () -> Label, input: () -> Input) {
//        let label = label()
//        let input = input()
//        #if DEBUG
//        let isFormLabel = label.classes.compactMap{ Utility(rawValue: $0) }.contains(.formLabel)
//        if !isFormLabel { print("ERROR: FormFloating label is not of class .formLabel") }
//        let isFormControl = input.classes.compactMap{ Utility(rawValue: $0) }.contains(.formControl)
//        if !isFormControl { print("ERROR: FormFloating input is not of class .formControl") }
//        #endif
//        let div = Div {
//            label
//            input
//        }
//        self.init(div)
//    }
//
//    public init(_ div: Div) {
//        div
//            .class(insert: .formFloating)
//
//        super.init(div)
//    }
}
