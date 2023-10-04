//
//  DateController .swift
//  Timer
//
//  Created by Евгений Борисов on 03.10.2023.
//

import Foundation

class DateController {
    
    var citiesAndTimezones = [
        "Moscow, Russia": "Europe/Moscow",
        "London, UK": "Europe/London",
        "Chita, Russia": "Asia/Chita"
    ]
    
    func getCurrentTimeOfTimezoneWith(identifier: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        format.timeZone = TimeZone(identifier: identifier)
        let currentTime = format.string(from: Date())
        return currentTime
    }
    
    func getTimeDifferenceWith(anotherTimeZoneIdentifier identifier: String) -> String {
        let secondsCurrent = TimeZone.current.secondsFromGMT()
        let secondsDifferent = TimeZone(identifier: identifier)!.secondsFromGMT()
        let secondsDifference =  secondsDifferent - secondsCurrent
        let hours = secondsDifference/3600
        if hours == 0 { return "+0" }
        return String(format: "%+.d", hours)
    }
    
    func calculateDayDifferenceWith(currentTime: String, andTimeDifference timeDifference: String) -> String {
        
        let reverseDifference: String
        if timeDifference.contains("+") {
            reverseDifference = timeDifference.replacingOccurrences(of: "+", with: "-")
        } else {
            reverseDifference = timeDifference.replacingOccurrences(of: "-", with: "+")
        }
        
        let currentTimeHour = Int(currentTime.prefix(2)) ?? 0
        let expression = NSExpression(format: "\(currentTimeHour)\(reverseDifference)")
        let currentLocationHour = (expression.expressionValue(with: nil, context: nil) as? Int) ?? 0
        
        
        let day: String
        
        if currentLocationHour > 24 {
            day = "Yesterday"
        } else if currentLocationHour < 0 {
            day = "Tomorrow"
        } else {
            day = "Today"
        }
        
        return day
        
    }
}
