//
//  CssProperty.swift
//  
//
//  Created by BG on 2/4/22.
//

public enum CssProperty: String {
    case alignContent = "align-content"
    case alignItems = "align-items"
    case alignSelf = "align-self"
    case all = "all"
    case animation = "animation"
    case animationDelay = "animation-delay"
    case animationDirection = "animation-direction"
    case animationDuration = "animation-duration"
    case animationFillMode = "animation-fill-mode"
    case animationIterationCount = "animation-iteration-count"
    case animationName = "animation-name"
    case animationPlayState = "animation-play-state"
    case animationTimingFunction = "animation-timing-function"
    case backfaceVisibility = "backface-visibility"
    case background = "background"
    case backgroundAttachment = "background-attachment"
    case backgroundBlendMode = "background-blend-mode"
    case backgroundClip = "background-clip"
    case backgroundColor = "background-color"
    case backgroundImage = "background-image"
    case backgroundOrigin = "background-origin"
    case backgroundPosition = "background-position"
    case backgroundRepeat = "background-repeat"
    case backgroundSize = "background-size"
    case border = "border"
    case borderBottom = "border-bottom"
    case borderBottomColor = "border-bottom-color"
    case borderBottomLeftRadius = "border-bottom-left-radius"
    case borderBottomRightRadius = "border-bottom-right-radius"
    case borderBottomStyle = "border-bottom-style"
    case borderBottomWidth = "border-bottom-width"
    case borderCollapse = "border-collapse"
    case borderColor = "border-color"
    case borderImage = "border-image"
    case borderImageOutset = "border-image-outset"
    case borderImageRepeat = "border-image-repeat"
    case borderImageSlice = "border-image-slice"
    case borderImageSource = "border-image-source"
    case borderImageWidth = "border-image-width"
    case borderLeft = "border-left"
    case borderLeftColor = "border-left-color"
    case borderLeftStyle = "border-left-style"
    case borderLeftWidth = "border-left-width"
    case borderRadius = "border-radius"
    case borderRight = "border-right"
    case borderRightColor = "border-right-color"
    case borderRightStyle = "border-right-style"
    case borderRightWidth = "border-right-width"
    case borderSpacing = "border-spacing"
    case borderStyle = "border-style"
    case borderTop = "border-top"
    case borderTopColor = "border-top-color"
    case borderTopLeftRadius = "border-top-left-radius"
    case borderTopRightRadius = "border-top-right-radius"
    case borderTopStyle = "border-top-style"
    case borderTopWidth = "border-top-width"
    case borderWidth = "border-width"
    case bottom = "bottom"
    case boxDecorationBreak = "box-decoration-break"
    case boxShadow = "box-shadow"
    case boxSizing = "box-sizing"
    case breakAfter = "break-after"
    case breakBefore = "break-before"
    case breakInside = "break-inside"
    case captionSide = "caption-side"
    case caretColor = "caret-color"
    case charset = "@charset"
    case clear = "clear"
    case clip = "clip"
    case color = "color"
    case columnCount = "column-count"
    case columnFill = "column-fill"
    case columnGap = "column-gap"
    case columnRule = "column-rule"
    case columnRuleColor = "column-rule-color"
    case columnRuleStyle = "column-rule-style"
    case columnRuleWidth = "column-rule-width"
    case columnSpan = "column-span"
    case columnWidth = "column-width"
    case columns = "columns"
    case content = "content"
    case counterIncrement = "counter-increment"
    case counterReset = "counter-reset"
    case cursor = "cursor"
    case direction = "direction"
    case display = "display"
    case emptyCells = "empty-cells"
    case filter = "filter"
    case flex = "flex"
    case flexBasis = "flex-basis"
    case flexDirection = "flex-direction"
    case flexFlow = "flex-flow"
    case flexGrow = "flex-grow"
    case flexShrink = "flex-shrink"
    case flexWrap = "flex-wrap"
    case float = "float"
    case font = "font"
    case fontFace = "@font-face"
    case fontFamily = "font-family"
    case fontFeatureSettings = "font-feature-settings"
    case fontFeatureValues = "@font-feature-values"
    case fontKerning = "font-kerning"
    case fontLanguageOverride = "font-language-override"
    case fontSize = "font-size"
    case fontSizeAdjust = "font-size-adjust"
    case fontStretch = "font-stretch"
    case fontStyle = "font-style"
    case fontSynthesis = "font-synthesis"
    case fontVariant = "font-variant"
    case fontVariantAlternates = "font-variant-alternates"
    case fontVariantCaps = "font-variant-caps"
    case fontVariantEastAsian = "font-variant-east-asian"
    case fontVariantLigatures = "font-variant-ligatures"
    case fontVariantNumeric = "font-variant-numeric"
    case fontVariantPosition = "font-variant-position"
    case fontWeight = "font-weight"
    case gap = "gap"
    case grid = "grid"
    case gridArea = "grid-area"
    case gridAutoColumns = "grid-auto-columns"
    case gridAutoFlow = "grid-auto-flow"
    case gridAutoRows = "grid-auto-rows"
    case gridColumn = "grid-column"
    case gridColumnEnd = "grid-column-end"
    case gridColumnGap = "grid-column-gap"
    case gridColumnStart = "grid-column-start"
    case gridGap = "grid-gap"
    case gridRow = "grid-row"
    case gridRowEnd = "grid-row-end"
    case gridRowGap = "grid-row-gap"
    case gridRowStart = "grid-row-start"
    case gridTemplate = "grid-template"
    case gridTemplateAreas = "grid-template-areas"
    case gridTemplateColumns = "grid-template-columns"
    case gridTemplateRows = "grid-template-rows"
    case hangingPunctuation = "hanging-punctuation"
    case height = "height"
    case hyphens = "hyphens"
    case imageRendering = "image-rendering"
    case `import` = "@import"
    case isolation = "isolation"
    case justifyContent = "justify-content"
    case keyframes = "@keyframes"
    case left = "left"
    case letterSpacing = "letter-spacing"
    case lineBreak = "line-break"
    case lineHeight = "line-height"
    case listStyle = "list-style"
    case listStyleImage = "list-style-image"
    case listStylePosition = "list-style-position"
    case listStyleType = "list-style-type"
    case margin = "margin"
    case marginBottom = "margin-bottom"
    case marginLeft = "margin-left"
    case marginRight = "margin-right"
    case marginTop = "margin-top"
    case mask = "mask"
    case maskClip = "mask-clip"
    case maskComposite = "mask-composite"
    case maskImage = "mask-image"
    case maskMode = "mask-mode"
    case maskOrigin = "mask-origin"
    case maskPosition = "mask-position"
    case maskRepeat = "mask-repeat"
    case maskSize = "mask-size"
    case maskType = "mask-type"
    case maxHeight = "max-height"
    case maxWidth = "max-width"
    case media = "@media"
    case minHeight = "min-height"
    case minWidth = "min-width"
    case mixBlendMode = "mix-blend-mode"
    case objectFit = "object-fit"
    case objectPosition = "object-position"
    case opacity = "opacity"
    case order = "order"
    case orphans = "orphans"
    case outline = "outline"
    case outlineColor = "outline-color"
    case outlineOffset = "outline-offset"
    case outlineStyle = "outline-style"
    case outlineWidth = "outline-width"
    case overflow = "overflow"
    case overflowWrap = "overflow-wrap"
    case overflowX = "overflow-x"
    case overflowY = "overflow-y"
    case padding = "padding"
    case paddingBottom = "padding-bottom"
    case paddingLeft = "padding-left"
    case paddingRight = "padding-right"
    case paddingTop = "padding-top"
    case pageBreakAfter = "page-break-after"
    case pageBreakBefore = "page-break-before"
    case pageBreakInside = "page-break-inside"
    case perspective = "perspective"
    case perspectiveOrigin = "perspective-origin"
    case pointerEvents = "pointer-events"
    case position = "position"
    case quotes = "quotes"
    case resize = "resize"
    case right = "right"
    case rowGap = "row-gap"
    case scrollBehavior = "scroll-behavior"
    case tabSize = "tab-size"
    case tableLayout = "table-layout"
    case textAlign = "text-align"
    case textAlignLast = "text-align-last"
    case textCombineUpright = "text-combine-upright"
    case textDecoration = "text-decoration"
    case textDecorationColor = "text-decoration-color"
    case textDecorationLine = "text-decoration-line"
    case textDecorationStyle = "text-decoration-style"
    case textDecorationThickness = "text-decoration-thickness"
    case textIndent = "text-indent"
    case textJustify = "text-justify"
    case textOrientation = "text-orientation"
    case textOverflow = "text-overflow"
    case textShadow = "text-shadow"
    case textTransform = "text-transform"
    case textUnderlinePosition = "text-underline-position"
    case top = "top"
    case transform = "transform"
    case transformOrigin = "transform-origin"
    case transformStyle = "transform-style"
    case transition = "transition"
    case transitionDelay = "transition-delay"
    case transitionDuration = "transition-duration"
    case transitionProperty = "transition-property"
    case transitionTimingFunction = "transition-timing-function"
    case unicodeBidi = "unicode-bidi"
    case userSelect = "user-select"
    case verticalAlign = "vertical-align"
    case visibility = "visibility"
    case whiteSpace = "white-space"
    case widows = "widows"
    case width = "width"
    case wordBreak = "word-break"
    case wordSpacing = "word-spacing"
    case wordWrap = "word-wrap"
    case writingMode = "writing-mode"
    case zIndex = "z-index"
}




/*
 
 STEPS TO GENERATING CssProperty
 
 1— go to https://www.w3schools.com/cssref/
 
 2- Copy everything
 
 3- Paste into spreadsheet
 
 4- Delete all columns except property names
 
 5- Export as .csv
 
 6- Open in TextEdit, Find+Replace newline with quote + comma + newline => Array of strings

 7- Copy and paste array of strings into Playground variable named 'cssProps'
 
 8- Execute this code:
 
         extension String {
             
             func replace(_ transform: (_ index: Int, _ current: Character, _ previous: Character?) -> String?) -> String {
                 var new = ""
                 self.unicodeScalars.enumerated().map {
                     let prevC = $0 > 0 ? self[self.index(self.startIndex, offsetBy: $0-1)] : nil
                     let newString = transform($0, Character($1), prevC)
                     if let newString = newString {
                         new += newString
                     }
                 }
                 return new
             }
             
             func hyphensToCamelCase() -> String {
                 replace { index, current, previous in
                     if current == "-" || current == "@" {
                         return nil
                     } else if let previous = previous, previous == "-" {
                         return current.uppercased()
                     }
                     return String(current)
                 }
             }
             
             func escapeIfReservedWord() -> String {
                 let reserved = ["import"]
                 if reserved.contains(self) {
                     return "`" + self + "`"
                 }
                 return self
             }
             
             func swiftEnum() -> String {
                 self.hyphensToCamelCase().escapeIfReservedWord()
             }
         }

         let cases = cssProps.map{ "case " + $0.swiftEnum() + " = \"\($0)\"" }

         let indent = "    "
         let cssProperty = "public enum CssProperty: String {\n" + indent + cases.joined(separator: "\n" + indent) + "\n}"

         print(cssProperty)

 
 9- Copy console output and paste into Xcode
 
 */
