//
//  FeedbackMessage.swift
//  Domain
//
//  Created by thanos kottaridis on 2/11/21.
//

import Foundation

public enum FeedbackMessageType {
    case success
    case error
    case info
}

public struct FeedbackMessage {
    public let message: String
    public let type: FeedbackMessageType
    
    public init(message: String, type: FeedbackMessageType) {
        self.message = message
        self.type = type
    }
}
