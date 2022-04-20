//
//  Icon.swift
//  
//
//  Created by Brad Gourley on 4/9/22.
//

import SwiftHtml

public enum Icon: String {
    case biAlarm = "bi-alarm"
    case biCalendar3 = "bi-calendar3"
    case biCart3 = "bi-cart3"
    case biCashCoin = "bi-cash-coin"
    case biChatQuote = "bi-chat-quote"
    case biChatLeftDots = "bi-chat-left-dots"
    case biCheck2Square = "bi-check2-square"
    case biCoin = "bi-coin"
    case biCurrencyDollar = "bi-currency-dollar"
    case biEmojiHeartEyes = "bi-emoji-heart-eyes"
    case biEnvelope = "bi-envelope"
    case biExclamationCircle = "bi-exclamation-circle"
    case biExclamationLg = "bi-exclamation-lg"
    case biExclamationTriangle = "bi-exclamation-triangle"
    case biEye = "bi-eye"
    case biHandIndexThumb = "bi-hand-index-thumb"
    case biMap = "bi-map"
    case biPlayCircle = "bi-play-circle"
    case biTelephone = "bi-telephone"
    case biThreeDots = "bi-three-dots"
}

extension Icon: TagRepresentable {
    
    public func build() -> Tag {
        I().class("bi \(self.rawValue)")
    }
}
