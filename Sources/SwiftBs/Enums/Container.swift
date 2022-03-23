//
//  Container.swift
//  
//
//  Created by Brad Gourley on 3/23/22.
//

import SwiftHtml

// Cases commented out do not init with { } ... can not be a container
public enum Container {
    case a
    case abbr
    case address
//        case area
    case article
    case aside
    case audio
    case b
//        case base
    case bdi
//        case bdo
    case blockquote
    case body
//        case br
    case button
    case canvas
    case caption
    case cite
    case code
//        case col
    case colgroup
//        case comment
//        case data
    case datalist
    case dd
    case del
    case details
    case dfn
    case dialog
    case div
    case dl
    case dt
    case em
//        case embed
    case fieldset
    case figcaption
    case figure
    case footer
    case form
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case head
    case header
//        case hr
    case html
    case i
    case iframe
//        case img
//        case input
    case ins
    case kbd
    case label
    case legend
    case li
//        case link
    case main
//        case map
    case mark
//        case meta
//        case meter
    case nav
    case noscript
    case object
    case ol
    case optgroup
    case option
    case output
    case p
//        case param
    case picture
    case pre
//        case progress
    case q
    case rp
    case rt
    case ruby
    case s
    case samp
    case script
    case section
    case select
    case small
//        case source
    case span
    case strong
    case style
    case sub
    case summary
    case sup
    case table
    case tbody
    case td
    case template
    case textarea
    case tfoot
    case th
    case thead
    case time
    case title
    case tr
//        case track
    case u
    case ul
    case `var`
    case video
    case wbr
    
    func tag(@TagBuilder _ contents: () -> [Tag]) -> Tag {
        switch self {
        case .a:
            return A { contents() }
        case .abbr:
            return Abbr { contents() }
        case .address:
            return Address { contents() }
        case .article:
            return Article { contents() }
        case .aside:
            return Aside { contents() }
        case .audio:
            return Audio { contents() }
        case .b:
            return B { contents() }
        case .bdi:
            return Bdi { contents() }
        case .blockquote:
            return Blockquote { contents() }
        case .body:
            return Body { contents() }
        case .button:
            return Button { contents() }
        case .canvas:
            return Canvas { contents() }
        case .caption:
            return Caption { contents() }
        case .cite:
            return Cite { contents() }
        case .code:
            return Code { contents() }
        case .colgroup:
            return Colgroup { contents() }
        case .datalist:
            return Datalist { contents() }
        case .dd:
            return Dd { contents() }
        case .del:
            return Del { contents() }
        case .details:
            return Details { contents() }
        case .dfn:
            return Dfn { contents() }
        case .dialog:
            return Dialog { contents() }
        case .dl:
            return Dl { contents() }
        case .dt:
            return Dt { contents() }
        case .em:
            return Em { contents() }
        case .fieldset:
            return Fieldset { contents() }
        case .figcaption:
            return Figcaption { contents() }
        case .figure:
            return Figure { contents() }
        case .footer:
            return Footer { contents() }
        case .form:
            return Form { contents() }
        case .h1:
            return H1 { contents() }
        case .h2:
            return H2 { contents() }
        case .h3:
            return H3 { contents() }
        case .h4:
            return H4 { contents() }
        case .h5:
            return H5 { contents() }
        case .h6:
            return H6 { contents() }
        case .head:
            return Head { contents() }
        case .header:
            return Header { contents() }
        case .html:
            return Html { contents() }
        case .i:
            return I { contents() }
        case .iframe:
            return Iframe { contents() }
        case .ins:
            return Ins { contents() }
        case .kbd:
            return Kbd { contents() }
        case .label:
            return Label { contents() }
        case .legend:
            return Legend { contents() }
        case .li:
            return Li { contents() }
        case .main:
            return Main { contents() }
        case .mark:
            return Mark { contents() }
        case .nav:
            return Nav { contents() }
        case .noscript:
            return Noscript { contents() }
        case .object:
            return Object { contents() }
        case .ol:
            return Ol { contents() }
        case .optgroup:
            return Optgroup { contents() }
        case .option:
            return Option { contents() }
        case .output:
            return Output { contents() }
        case .p:
            return P { contents() }
        case .picture:
            return Picture { contents() }
        case .pre:
            return Pre { contents() }
        case .q:
            return Q { contents() }
        case .rp:
            return Rp { contents() }
        case .rt:
            return Rt { contents() }
        case .ruby:
            return Ruby { contents() }
        case .s:
            return S { contents() }
        case .samp:
            return Samp { contents() }
        case .script:
            return Script { contents() }
        case .section:
            return Section { contents() }
        case .select:
            return Select { contents() }
        case .small:
            return Small { contents() }
        case .span:
            return Span { contents() }
        case .strong:
            return Strong { contents() }
        case .style:
            return Style { contents() }
        case .sub:
            return Sub { contents() }
        case .summary:
            return Summary { contents() }
        case .sup:
            return Sup { contents() }
        case .table:
            return Table { contents() }
        case .tbody:
            return Tbody { contents() }
        case .td:
            return Td { contents() }
        case .template:
            return Template { contents() }
        case .textarea:
            return Textarea { contents() }
        case .tfoot:
            return Tfoot { contents() }
        case .th:
            return Th { contents() }
        case .thead:
            return Thead { contents() }
        case .time:
            return Time { contents() }
        case .title:
            return Title { contents() }
        case .tr:
            return Tr { contents() }
        case .u:
            return U { contents() }
        case .ul:
            return Ul { contents() }
        case .`var`:
            return Var { contents() }
        case .video:
            return Video { contents() }
        case .wbr:
            return Wbr { contents() }
        case .div:
//                    .area,
//                    .base,
//                    .bdo,
//                    .br,
//                    .col,
//                    .comment,
//                    .data,
//                    .embed,
//                    .hr,
//                    .img,
//                    .input,
//                    .link,
//                    .map,
//                    .meta,
//                    .meter,
//                    .param,
//                    .progress,
//                    .source,
//                    .track:
            return Div { contents() }
        }
    }
}
