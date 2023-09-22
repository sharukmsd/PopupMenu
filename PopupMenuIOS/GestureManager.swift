//
//  GestureManager.swift
//  PopupMenuIOS
//
//  Created by Shahrukh on 22/09/2023.
//

import SwiftUI

enum SwipeDirection: String {
    case left, right, up, down, none
}

struct GestureManager {
    static func detectDirection(value: DragGesture.Value) -> SwipeDirection {
        if value.startLocation.x < value.location.x - 12 {
            return .left
        }
        if value.startLocation.x > value.location.x + 12 {
            return .right
        }
        if value.startLocation.y < value.location.y - 12 {
            return .down
        }
        if value.startLocation.y > value.location.y {
            return .up
        }
        return .none
    }
}
