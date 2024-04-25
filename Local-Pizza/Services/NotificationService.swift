//
//  NotificationService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 22.03.2024.
//

import UIKit
import UserNotifications

class NotificationService {
    
    static let shared = NotificationService()
    private init() {}
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                print("Разрешение на отправку уведомлений получено")
            } else {
                print("Разрешение на отправку уведомлений отклонено")
            }
        }
    }
    
    func scheduleDailyNotification(at hour: Int, minute: Int = 0) {
        let content = UNMutableNotificationContent()
        content.title = "Не пропусти новые акции!"
        content.body = "Только в приложении"
        content.sound = UNNotificationSound.default
        
        var dataComponents = DateComponents()
        dataComponents.hour = hour
        dataComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при планировании уведомления: \(error)")
            } else {
                print("Ежедневное уведомление запланировано на \(hour):\(minute)")
            }
        }
    }
    
    func cancelDailyNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyNotification"])
        print("Ежедневные уведомления отменены")
    }
}
