//
//  DispatchQueue.swift
//  SMHS
//
//  Created by Jevon Mao on 4/3/22.
//

import Foundation
import OSLog

extension DispatchQueue {
    private static let storage = UserDefaults.standard

    static func runTask(_ task: () -> Void,
                        name: String,
                        every interval: TimeInterval)
    {
        let logger = Logger(category: .core)
        logger.log(level: .error,
                   "<DispatchQueue.runTask()>: task <\(name, privacy: .public)> scheduled, interval: \(interval, privacy: .public) secs")
        if let lastReload = storage.object(forKey: name) as? Date
        {
            // minimum reload interval is 6 hours
            let lastReload = abs(Date().timeIntervalSince(lastReload))
            if lastReload > interval {
                logger.log(level: .info, "Task reload success, last reload: \(lastReload, privacy: .public) secs ago, minimum: \(interval, privacy: .public)")
                task()
                setLastReloadTime(key: name)
            }
            logger.log(level: .error, "<DispatchQuene.runTask()>: Reload cancelled, last reload: \(lastReload) secs, minimum: \(interval, privacy: .public) secs.")
        }
        else {
            setLastReloadTime(key: name)
            logger.log(level: .info, "Task reload triggered with new reloader key (\(name, privacy: .public))")
            task()
        }
    }

    private static func setLastReloadTime(to time: Date = Date(), key: String)
    {
        storage.set(time, forKey: key)
    }
}
