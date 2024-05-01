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
                print("Разрешение на отправку уведомлений получено".localized())
            } else {
                print("Разрешение на отправку уведомлений отклонено".localized())
            }
        }
    }
    
    func scheduleDailyNotification(at hour: Int, minute: Int = 0) {
        let content = UNMutableNotificationContent()
        content.title = "Не пропусти новые акции!".localized()
        content.body = "Только в приложении".localized()
        content.sound = UNNotificationSound.default
        
        var dataComponents = DateComponents()
        dataComponents.hour = hour
        dataComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Daily notification scheduled for \(hour):\(minute)")
            }
        }
    }
    
    func cancelDailyNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyNotification"])
        print("Ежедневные уведомления отменены".localized())
    }
}
