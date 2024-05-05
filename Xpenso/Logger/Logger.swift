import os.log

enum LogLevel {
    case debug, info, error, fault
}

class Logger {
    private static let subsystem = "com.arka.xpenso"
    private static let category = "ExpenseTracking"
    
    static func log(_ level: LogLevel, _ message: String, _ args: CVarArg...) {
        let log = OSLog(subsystem: subsystem, category: category)
        
        switch level {
        case .debug:
            os_log("%{public}@", log: log, type: .debug, message, args)
        case .info:
            os_log("%{public}@", log: log, type: .info, message, args)
        case .error:
            os_log("%{public}@", log: log, type: .error, message, args)
        case .fault:
            os_log("%{public}@", log: log, type: .fault, message, args)
        }
    }
}
