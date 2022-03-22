//
//  CssKeyValue.swift
//  
//
//  Created by BG on 2/10/22.
//

public struct CssKeyValue {

    let key: String
    let value: String
    
    public init?(_ key: String, _ value: String?) {
        self.init(key: key, value: value)
    }

    public init?(key: String, value: String?) {
        guard
            !key.isEmpty,
            !key.contains(":"),
            !key.contains(";"),
            let value = value,
            !value.isEmpty,
            !value.contains(":"),
            !value.contains(";")
        else { return nil }
        
        self.key = key
        self.value = value
    }
}

extension CssKeyValue {

    public init?(_ property: CssProperty, _ value: String?) {
       self.init(property.rawValue, value)
    }
    
    public static func alignContent(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.alignContent, value)
    }

    public static func alignItems(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.alignItems, value)
    }

    public static func alignSelf(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.alignSelf, value)
    }

    public static func all(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.all, value)
    }

    public static func animation(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animation, value)
    }

    public static func animationDelay(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationDelay, value)
    }

    public static func animationDirection(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationDirection, value)
    }

    public static func animationDuration(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationDuration, value)
    }

    public static func animationFillMode(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationFillMode, value)
    }

    public static func animationIterationCount(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationIterationCount, value)
    }

    public static func animationName(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationName, value)
    }

    public static func animationPlayState(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationPlayState, value)
    }

    public static func animationTimingFunction(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.animationTimingFunction, value)
    }

    public static func backfaceVisibility(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backfaceVisibility, value)
    }

    public static func background(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.background, value)
    }

    public static func backgroundAttachment(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundAttachment, value)
    }

    public static func backgroundBlendMode(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundBlendMode, value)
    }

    public static func backgroundClip(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundClip, value)
    }

    public static func backgroundColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundColor, value)
    }

    public static func backgroundImage(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundImage, value)
    }

    public static func backgroundOrigin(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundOrigin, value)
    }

    public static func backgroundPosition(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundPosition, value)
    }

    public static func backgroundRepeat(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundRepeat, value)
    }

    public static func backgroundSize(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.backgroundSize, value)
    }

    public static func border(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.border, value)
    }

    public static func borderBottom(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderBottom, value)
    }

    public static func borderBottomColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderBottomColor, value)
    }

    public static func borderBottomLeftRadius(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderBottomLeftRadius, value)
    }

    public static func borderBottomRightRadius(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderBottomRightRadius, value)
    }

    public static func borderBottomStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderBottomStyle, value)
    }

    public static func borderBottomWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderBottomWidth, value)
    }

    public static func borderCollapse(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderCollapse, value)
    }

    public static func borderColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderColor, value)
    }

    public static func borderImage(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderImage, value)
    }

    public static func borderImageOutset(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderImageOutset, value)
    }

    public static func borderImageRepeat(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderImageRepeat, value)
    }

    public static func borderImageSlice(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderImageSlice, value)
    }

    public static func borderImageSource(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderImageSource, value)
    }

    public static func borderImageWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderImageWidth, value)
    }

    public static func borderLeft(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderLeft, value)
    }

    public static func borderLeftColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderLeftColor, value)
    }

    public static func borderLeftStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderLeftStyle, value)
    }

    public static func borderLeftWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderLeftWidth, value)
    }

    public static func borderRadius(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderRadius, value)
    }

    public static func borderRight(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderRight, value)
    }

    public static func borderRightColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderRightColor, value)
    }

    public static func borderRightStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderRightStyle, value)
    }

    public static func borderRightWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderRightWidth, value)
    }

    public static func borderSpacing(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderSpacing, value)
    }

    public static func borderStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderStyle, value)
    }

    public static func borderTop(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderTop, value)
    }

    public static func borderTopColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderTopColor, value)
    }

    public static func borderTopLeftRadius(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderTopLeftRadius, value)
    }

    public static func borderTopRightRadius(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderTopRightRadius, value)
    }

    public static func borderTopStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderTopStyle, value)
    }

    public static func borderTopWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderTopWidth, value)
    }

    public static func borderWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.borderWidth, value)
    }

    public static func bottom(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.bottom, value)
    }

    public static func boxDecorationBreak(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.boxDecorationBreak, value)
    }

    public static func boxShadow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.boxShadow, value)
    }

    public static func boxSizing(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.boxSizing, value)
    }

    public static func breakAfter(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.breakAfter, value)
    }

    public static func breakBefore(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.breakBefore, value)
    }

    public static func breakInside(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.breakInside, value)
    }

    public static func captionSide(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.captionSide, value)
    }

    public static func caretColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.caretColor, value)
    }

    public static func charset(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.charset, value)
    }

    public static func clear(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.clear, value)
    }

    public static func clip(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.clip, value)
    }

    public static func color(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.color, value)
    }

    public static func columnCount(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnCount, value)
    }

    public static func columnFill(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnFill, value)
    }

    public static func columnGap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnGap, value)
    }

    public static func columnRule(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnRule, value)
    }

    public static func columnRuleColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnRuleColor, value)
    }

    public static func columnRuleStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnRuleStyle, value)
    }

    public static func columnRuleWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnRuleWidth, value)
    }

    public static func columnSpan(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnSpan, value)
    }

    public static func columnWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columnWidth, value)
    }

    public static func columns(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.columns, value)
    }

    public static func content(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.content, value)
    }

    public static func counterIncrement(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.counterIncrement, value)
    }

    public static func counterReset(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.counterReset, value)
    }

    public static func cursor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.cursor, value)
    }

    public static func direction(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.direction, value)
    }

    public static func display(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.display, value)
    }

    public static func emptyCells(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.emptyCells, value)
    }

    public static func filter(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.filter, value)
    }

    public static func flex(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.flex, value)
    }

    public static func flexBasis(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.flexBasis, value)
    }

    public static func flexDirection(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.flexDirection, value)
    }

    public static func flexFlow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.flexFlow, value)
    }

    public static func flexGrow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.flexGrow, value)
    }

    public static func flexShrink(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.flexShrink, value)
    }

    public static func flexWrap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.flexWrap, value)
    }

    public static func float(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.float, value)
    }

    public static func font(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.font, value)
    }

    public static func fontFace(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontFace, value)
    }

    public static func fontFamily(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontFamily, value)
    }

    public static func fontFeatureSettings(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontFeatureSettings, value)
    }

    public static func fontFeatureValues(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontFeatureValues, value)
    }

    public static func fontKerning(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontKerning, value)
    }

    public static func fontLanguageOverride(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontLanguageOverride, value)
    }

    public static func fontSize(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontSize, value)
    }

    public static func fontSizeAdjust(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontSizeAdjust, value)
    }

    public static func fontStretch(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontStretch, value)
    }

    public static func fontStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontStyle, value)
    }

    public static func fontSynthesis(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontSynthesis, value)
    }

    public static func fontVariant(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontVariant, value)
    }

    public static func fontVariantAlternates(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontVariantAlternates, value)
    }

    public static func fontVariantCaps(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontVariantCaps, value)
    }

    public static func fontVariantEastAsian(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontVariantEastAsian, value)
    }

    public static func fontVariantLigatures(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontVariantLigatures, value)
    }

    public static func fontVariantNumeric(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontVariantNumeric, value)
    }

    public static func fontVariantPosition(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontVariantPosition, value)
    }

    public static func fontWeight(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.fontWeight, value)
    }

    public static func gap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gap, value)
    }

    public static func grid(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.grid, value)
    }

    public static func gridArea(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridArea, value)
    }

    public static func gridAutoColumns(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridAutoColumns, value)
    }

    public static func gridAutoFlow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridAutoFlow, value)
    }

    public static func gridAutoRows(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridAutoRows, value)
    }

    public static func gridColumn(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridColumn, value)
    }

    public static func gridColumnEnd(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridColumnEnd, value)
    }

    public static func gridColumnGap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridColumnGap, value)
    }

    public static func gridColumnStart(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridColumnStart, value)
    }

    public static func gridGap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridGap, value)
    }

    public static func gridRow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridRow, value)
    }

    public static func gridRowEnd(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridRowEnd, value)
    }

    public static func gridRowGap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridRowGap, value)
    }

    public static func gridRowStart(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridRowStart, value)
    }

    public static func gridTemplate(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridTemplate, value)
    }

    public static func gridTemplateAreas(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridTemplateAreas, value)
    }

    public static func gridTemplateColumns(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridTemplateColumns, value)
    }

    public static func gridTemplateRows(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.gridTemplateRows, value)
    }

    public static func hangingPunctuation(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.hangingPunctuation, value)
    }

    public static func height(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.height, value)
    }

    public static func hyphens(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.hyphens, value)
    }

    public static func imageRendering(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.imageRendering, value)
    }

    public static func `import`(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.`import`, value)
    }

    public static func isolation(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.isolation, value)
    }

    public static func justifyContent(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.justifyContent, value)
    }

    public static func keyframes(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.keyframes, value)
    }

    public static func left(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.left, value)
    }

    public static func letterSpacing(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.letterSpacing, value)
    }

    public static func lineBreak(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.lineBreak, value)
    }

    public static func lineHeight(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.lineHeight, value)
    }

    public static func listStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.listStyle, value)
    }

    public static func listStyleImage(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.listStyleImage, value)
    }

    public static func listStylePosition(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.listStylePosition, value)
    }

    public static func listStyleType(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.listStyleType, value)
    }

    public static func margin(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.margin, value)
    }

    public static func marginBottom(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.marginBottom, value)
    }

    public static func marginLeft(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.marginLeft, value)
    }

    public static func marginRight(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.marginRight, value)
    }

    public static func marginTop(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.marginTop, value)
    }

    public static func mask(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.mask, value)
    }

    public static func maskClip(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskClip, value)
    }

    public static func maskComposite(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskComposite, value)
    }

    public static func maskImage(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskImage, value)
    }

    public static func maskMode(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskMode, value)
    }

    public static func maskOrigin(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskOrigin, value)
    }

    public static func maskPosition(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskPosition, value)
    }

    public static func maskRepeat(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskRepeat, value)
    }

    public static func maskSize(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskSize, value)
    }

    public static func maskType(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maskType, value)
    }

    public static func maxHeight(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maxHeight, value)
    }

    public static func maxWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.maxWidth, value)
    }

    public static func media(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.media, value)
    }

    public static func minHeight(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.minHeight, value)
    }

    public static func minWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.minWidth, value)
    }

    public static func mixBlendMode(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.mixBlendMode, value)
    }

    public static func objectFit(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.objectFit, value)
    }

    public static func objectPosition(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.objectPosition, value)
    }

    public static func opacity(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.opacity, value)
    }

    public static func order(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.order, value)
    }

    public static func orphans(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.orphans, value)
    }

    public static func outline(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.outline, value)
    }

    public static func outlineColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.outlineColor, value)
    }

    public static func outlineOffset(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.outlineOffset, value)
    }

    public static func outlineStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.outlineStyle, value)
    }

    public static func outlineWidth(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.outlineWidth, value)
    }

    public static func overflow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.overflow, value)
    }

    public static func overflowWrap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.overflowWrap, value)
    }

    public static func overflowX(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.overflowX, value)
    }

    public static func overflowY(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.overflowY, value)
    }

    public static func padding(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.padding, value)
    }

    public static func paddingBottom(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.paddingBottom, value)
    }

    public static func paddingLeft(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.paddingLeft, value)
    }

    public static func paddingRight(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.paddingRight, value)
    }

    public static func paddingTop(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.paddingTop, value)
    }

    public static func pageBreakAfter(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.pageBreakAfter, value)
    }

    public static func pageBreakBefore(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.pageBreakBefore, value)
    }

    public static func pageBreakInside(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.pageBreakInside, value)
    }

    public static func perspective(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.perspective, value)
    }

    public static func perspectiveOrigin(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.perspectiveOrigin, value)
    }

    public static func pointerEvents(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.pointerEvents, value)
    }

    public static func position(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.position, value)
    }

    public static func quotes(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.quotes, value)
    }

    public static func resize(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.resize, value)
    }

    public static func right(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.right, value)
    }

    public static func rowGap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.rowGap, value)
    }

    public static func scrollBehavior(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.scrollBehavior, value)
    }

    public static func tabSize(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.tabSize, value)
    }

    public static func tableLayout(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.tableLayout, value)
    }

    public static func textAlign(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textAlign, value)
    }

    public static func textAlignLast(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textAlignLast, value)
    }

    public static func textCombineUpright(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textCombineUpright, value)
    }

    public static func textDecoration(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textDecoration, value)
    }

    public static func textDecorationColor(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textDecorationColor, value)
    }

    public static func textDecorationLine(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textDecorationLine, value)
    }

    public static func textDecorationStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textDecorationStyle, value)
    }

    public static func textDecorationThickness(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textDecorationThickness, value)
    }

    public static func textIndent(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textIndent, value)
    }

    public static func textJustify(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textJustify, value)
    }

    public static func textOrientation(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textOrientation, value)
    }

    public static func textOverflow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textOverflow, value)
    }

    public static func textShadow(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textShadow, value)
    }

    public static func textTransform(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textTransform, value)
    }

    public static func textUnderlinePosition(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.textUnderlinePosition, value)
    }

    public static func top(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.top, value)
    }

    public static func transform(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transform, value)
    }

    public static func transformOrigin(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transformOrigin, value)
    }

    public static func transformStyle(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transformStyle, value)
    }

    public static func transition(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transition, value)
    }

    public static func transitionDelay(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transitionDelay, value)
    }

    public static func transitionDuration(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transitionDuration, value)
    }

    public static func transitionProperty(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transitionProperty, value)
    }

    public static func transitionTimingFunction(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.transitionTimingFunction, value)
    }

    public static func unicodeBidi(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.unicodeBidi, value)
    }

    public static func userSelect(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.userSelect, value)
    }

    public static func verticalAlign(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.verticalAlign, value)
    }

    public static func visibility(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.visibility, value)
    }

    public static func whiteSpace(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.whiteSpace, value)
    }

    public static func widows(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.widows, value)
    }

    public static func width(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.width, value)
    }

    public static func wordBreak(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.wordBreak, value)
    }

    public static func wordSpacing(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.wordSpacing, value)
    }

    public static func wordWrap(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.wordWrap, value)
    }

    public static func writingMode(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.writingMode, value)
    }

    public static func zIndex(_ value: String?) -> CssKeyValue? {
        CssKeyValue(.zIndex, value)
    }
}

extension String {
    
    init(_ kv: CssKeyValue) {
        self.init("\(kv.key):\(kv.value);")
    }
}


/*
 
 STEPS TO GENERATING CssKeyValue
 
 1- Follow steps in CssProperty for getting array of hyphenated property strings into Playgrounds variable called 'cssProps'
 
 2- Execute this code:
 
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

                 func staticFunc() -> String {
                     return """
                     
                         public static func \(self)(_ value: String?) -> CssKeyValue? {
                             CssKeyValue(.\(self), value)
                         }
                     """
                 }

             }

             let CssKeyValue = """
             public struct CssKeyValue {

                 let key: String
                 let value: String
                 
                 public init?(_ key: String, _ value: String?) {
                     self.init(key: key, value: value)
                 }

                 public init?(key: String, value: String?) {
                     guard
                         !key.isEmpty,
                         !key.contains(":"),
                         !key.contains(";"),
                         let value = value,
                         !value.isEmpty,
                         !value.contains(":"),
                         !value.contains(";")
                     else { return nil }
                     
                     self.key = key
                     self.value = value
                 }
             }
             
             extension CssKeyValue {

                 public init?(_ property: CssProperty, _ value: String?) {
                    self.init(property.rawValue, value)
                 }
                 \(cssProps.map { $0.swiftEnum().staticFunc() }.joined(separator: "\n"))
             }

             extension String {
                 
                 init(_ kv: CssKeyValue) {
                     self.init("\\(kv.key):\\(kv.value);")
                 }
             }
             """

             print(CssKeyValue)

 3- Copy console output and paste into Xcode

 */
