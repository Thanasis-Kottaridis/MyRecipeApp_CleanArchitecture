//
//  FeedbackMessage.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation

enum FeedbackMessageType {
    case success
    case error
    case info
}

struct FeedbackMessage {
    let message: String
    let type: FeedbackMessageType
}
