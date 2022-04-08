//
//  Logger.swift
//  SMHS
//
//  Created by Jevon Mao on 4/7/22.
//

import OSLog

extension Logger {
    enum Category: String {
        case network, core, announcement
    }
    init(category: Category)
    {
        self.init(subsystem: Bundle.main.bundleIdentifier!,
                  category: category.rawValue)
    }
}
