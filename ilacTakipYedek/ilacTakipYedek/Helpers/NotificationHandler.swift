//
//  NotificationHandler.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 31.03.2024.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermisson() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert,.badge, .sound]) { success, error in
                if success {
                    print("Access granted!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
        }
    }
    
    func cancelNotification(withIdentifier identifier: String) {
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func sendNotification(date: Date, time: Date, title: String, body: String, medicationID: String) {
        // Tarih ve saat bileşenlerini ayır
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        
        // Bildirimin tetikleyicisi, tarih ve saat bileşenlerini kullanarak oluşturulur
        var triggerDateComponents = DateComponents()
        triggerDateComponents.year = dateComponents.year
        triggerDateComponents.month = dateComponents.month
        triggerDateComponents.day = dateComponents.day
        triggerDateComponents.hour = timeComponents.hour
        triggerDateComponents.minute = timeComponents.minute
        
        // Bildirimin tetikleyicisini oluştur
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let sound = UNNotificationSound(named:UNNotificationSoundName(rawValue: "pill.mp3"))
        content.sound = sound
        
        // Bildirim içeriği oluştur
        
        
        let requestIdentifier = medicationID
        
        // Bildirim isteğini oluştur ve planla
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
