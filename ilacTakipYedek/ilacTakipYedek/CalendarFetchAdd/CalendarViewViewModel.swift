//
//  CalendarViewViewModel.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 16.03.2024.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth

class CalendarViewViewModel: ObservableObject {
    
    @Published var medicineName = ""
    @Published var medicineType = ""
    @Published var frequencyOfTakingTheDrug = ""
    @Published var medicine: Medicine?
    @Published var selectedDate: Date = Date()
    @Published var medicines = [Medicine]()
    @Published var selectedTime: Date = Date()
    @Published var OtherView = false
    @Published var notificationPermissionGranted = false
    @Published var isDeleting = false
    @Published var isEditing = false
    @Published var remindType = ""
    @Published var selectedDates : [Date] = []
    @Published var updatedData: [String: Any] = [:]
    @Published var properties = ""

    init(){}
    
    
    func add() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let notify = NotificationHandler()
        notify.askPermisson()
        
        // Seçilen tarihler için işlem yap
        for selectedDate in selectedDates {
            let formattedDate = formatDate(date: selectedDate)
            
            let medicineId = userId
            var baseMedicine = Medicine(id: medicineId, documentId: userId,date: formattedDate, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: formatTime(time: selectedTime), remindType: remindType,properties: properties)
            
            // İlaç zamanlarını hesapla ve ilaçları ekleyerek Firebase'e gönder
            switch remindType {
            case "Twice a day":
                let firstTime = selectedTime
                let secondTime = Calendar.current.date(byAdding: .hour, value: 12, to: firstTime)!
                addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime],selectedDate: selectedDate)
                
                if Calendar.current.component(.hour, from: firstTime) > 12 && Calendar.current.component(.hour, from: firstTime) < 24 {
                    let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                    let nextSelectedDay = formatDate(date: nextDay)
                    
                    baseMedicine = Medicine(id: medicineId, documentId: userId,date: nextSelectedDay, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: formatTime(time: selectedTime), remindType: remindType,properties: properties)
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [secondTime],selectedDate: nextDay)
                } else {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [secondTime],selectedDate: selectedDate)
                }
                
            case "3 Times a day":
                let firstTime = selectedTime
                let secondTime = Calendar.current.date(byAdding: .hour, value: 8, to: firstTime)!
                let thirdTime = Calendar.current.date(byAdding: .hour, value: 16, to: firstTime)!
                
                if Calendar.current.component(.hour, from: firstTime) > 0 && Calendar.current.component(.hour, from: firstTime) < 8 {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime, secondTime, thirdTime],selectedDate: selectedDate)
                } else if Calendar.current.component(.hour, from: firstTime) > 8 && Calendar.current.component(.hour, from: firstTime) < 16 {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime, secondTime],selectedDate: selectedDate)
                    let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                    let nextSelectedDay = formatDate(date: nextDay)
                    
                    baseMedicine = Medicine(id: medicineId, documentId: userId,date: nextSelectedDay, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: formatTime(time: selectedTime), remindType: remindType,properties: properties)
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [thirdTime],selectedDate: nextDay)
                } else {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime],selectedDate: selectedDate)
                    let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                    let nextSelectedDay = formatDate(date: nextDay)
                    
                    baseMedicine = Medicine(id: medicineId, documentId: userId,date: nextSelectedDay, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: formatTime(time: selectedTime), remindType: remindType,properties: properties)
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [secondTime, thirdTime],selectedDate: nextDay)
                    
                }
                
            case "4 Times a day":
                let firstTime = selectedTime
                let secondTime = Calendar.current.date(byAdding: .hour, value: 6, to: firstTime)!
                let thirdTime = Calendar.current.date(byAdding: .hour, value: 12, to: firstTime)!
                let fourthTime = Calendar.current.date(byAdding: .hour, value: 18, to: firstTime)!
                
                if Calendar.current.component(.hour, from: firstTime) > 0 && Calendar.current.component(.hour, from: firstTime) < 6 {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime, secondTime, thirdTime, fourthTime],selectedDate: selectedDate)
                } else if Calendar.current.component(.hour, from: firstTime) > 6 && Calendar.current.component(.hour, from: firstTime) < 12 {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime, secondTime, thirdTime],selectedDate: selectedDate)
                    let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                    let nextSelectedDay = formatDate(date: nextDay)
                    
                    baseMedicine = Medicine(id: medicineId,documentId: userId, date: nextSelectedDay, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: formatTime(time: selectedTime), remindType: remindType,properties: properties)
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [fourthTime],selectedDate: nextDay)
                } else if Calendar.current.component(.hour, from: firstTime) > 12 && Calendar.current.component(.hour, from: firstTime) < 18 {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime, secondTime], selectedDate: selectedDate)
                    let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                    let nextSelectedDay = formatDate(date: nextDay)
                    
                    baseMedicine = Medicine(id: medicineId,documentId: userId, date: nextSelectedDay, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: formatTime(time: selectedTime), remindType: remindType,properties: properties)
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [ thirdTime, fourthTime],selectedDate: nextDay)
                } else {
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [firstTime],selectedDate: selectedDate)
                    let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                    let nextSelectedDay = formatDate(date: nextDay)
                    
                    baseMedicine = Medicine(id: medicineId, documentId: userId,date: nextSelectedDay, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: formatTime(time: selectedTime), remindType: remindType, properties: properties)
                    addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [secondTime, thirdTime, fourthTime],selectedDate: nextDay)
                }
                
            default:
                // Diğer durumlar için sadece seçilen saati kullan
                addMedicineWithTimes(userId: userId, medicine: baseMedicine, times: [selectedTime], selectedDate: selectedDate)
                
            }
            //print(medicineId)
            
        }
    }
    
    
    private func addMedicineWithTimes(userId: String, medicine: Medicine, times: [Date], selectedDate: Date) {
        let db = Firestore.firestore()
        let notify = NotificationHandler()
        for time in times {
            // İlaç için veriyi oluştur
            let medicineId = UUID().uuidString
            
            let data: [String: Any] = [
                "medicineName": medicine.medicineName,
                "medicineType": medicine.medicineType,
                "frequencyOfTakingTheDrug": medicine.frequencyOfTakingTheDrug,
                "date": medicine.date,
                "time": formatTime(time: time),
                "remindType": medicine.remindType,
                "id": medicineId,
                "documentId" : medicine.documentId,
                "properties" : medicine.properties
            ]
            // Firestore koleksiyonuna ekle
            db.collection("ilaclar")
                .document(userId)
                .collection("ilacListesi")
                .addDocument(data: data)
            
            notify.sendNotification(date: selectedDate, time: time, title: "It's time for your medicine!", body: "\(medicine.medicineName), \(medicine.medicineType), \(medicine.frequencyOfTakingTheDrug)", medicationID: medicineId)
            
        }
        
    }
    
    func deleteMed(medicine: Medicine) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        deleteMedicine(userId: userId, medicineId: medicine.documentId)
        let notify = NotificationHandler()
        notify.cancelNotification(withIdentifier: medicine.id)
    }
    
    private func deleteMedicine(userId: String, medicineId: String) {
        isDeleting = true
        let db = Firestore.firestore()
        db.collection("ilaclar")
            .document(userId)
            .collection("ilacListesi")
            .document(medicineId)
            .delete { error in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                } else {
                    print("Document successfully removed!")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        // Simüle edilen silme işlemi için 0.5 saniye bekleme
                        self.isDeleting = false
                    }
                    // İlaçları güncelle (Firebase'den kaldır)
                    self.medicines.removeAll { $0.id == medicineId }
                    
                }
            }
        
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Custom format string
        formatter.timeZone = TimeZone.current // Add timezone for consistency
        return formatter.string(from: date)
    }
    
    private func formatTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Custom format string
        formatter.timeZone = TimeZone.current // Add timezone for consistency
        return formatter.string(from: time)
    }
    
    func update(medicine: Medicine, updatedData: [String: Any]) {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        updateMedicine(userId: userId, medicineId: medicine.documentId, updatedData: updatedData)
    }
    
    private func updateMedicine(userId: String, medicineId: String, updatedData: [String: Any]) {
        let db = Firestore.firestore()
        
        db.collection("ilaclar")
            .document(userId)
            .collection("ilacListesi")
            .document(medicineId)
            .updateData(updatedData) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    
                    print("Succes update")
                }
            }
    }
    
    func fetch() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let formattedDate = formatDate(date: selectedDate)
        let formattedTime = formatTime(time: selectedTime)
        fetchMedicines(userId: userId, date: formattedDate, time: formattedTime)
        
    }
    
    private func fetchMedicines(userId: String, date: String, time: String) {
        let db = Firestore.firestore()
        db.collection("ilaclar")
            .document(userId)
            .collection("ilacListesi")
            .whereField("date", isEqualTo: date)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("No data available: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("Document not found")
                    return
                }
                
                // Firestore'dan gelen veriler
                let medicines = documents.compactMap { queryDocumentSnapshot in
                    let data = queryDocumentSnapshot.data()
                    let documentId = queryDocumentSnapshot.documentID
                    let id = data["id"] as? String ?? ""
                    let medicineName = data["medicineName"] as? String ?? ""
                    let medicineType = data["medicineType"] as? String ?? ""
                    let frequencyOfTakingTheDrug = data["frequencyOfTakingTheDrug"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let remindType = data["remindType"] as? String ?? ""
                    let properties = data["properties"] as? String ?? ""
                    //let date = data["date"] as? String ?? ""
                    
                    return Medicine(id: id, documentId: documentId, date: date, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: time, remindType: remindType, properties: properties)
                }
                
                self.medicines = medicines
                
            }
    }
     
    func fetchAllMedicines() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        fetchAllMedicines(userId: userId)
    }
    /*
    private func fetchAllMedicines(userId: String) {
        let db = Firestore.firestore()
        db.collection("ilaclar")
            .document(userId)
            .collection("ilacListesi")
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching medicines: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No medicine documents found")
                    return
                }
                
                var allMedicines = [Medicine]()
                
                // Her döküman için ilaç oluştur
                for document in documents {
                    let data = document.data()
                    let documentId = document.documentID
                    let id = data["id"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let medicineName = data["medicineName"] as? String ?? ""
                    let medicineType = data["medicineType"] as? String ?? ""
                    let frequencyOfTakingTheDrug = data["frequencyOfTakingTheDrug"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let remindType = data["remindType"] as? String ?? ""
                    
                    let medicine = Medicine(id: id, documentId: documentId, date: date, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: time, remindType: remindType)
                    
                    allMedicines.append(medicine)
                }
                
                // Tüm ilaçları güncelle
                self.medicines = allMedicines
            }
    }*/
    
    private func fetchAllMedicines(userId: String) {
        let db = Firestore.firestore()
        db.collection("ilaclar")
            .document(userId)
            .collection("ilacListesi")
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching medicines: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No medicine documents found")
                    return
                }
                
                var allMedicines = [Medicine]()
                
                // Her döküman için ilaç oluştur
                for document in documents {
                    let data = document.data()
                    let documentId = document.documentID
                    let id = data["id"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let medicineName = data["medicineName"] as? String ?? ""
                    let medicineType = data["medicineType"] as? String ?? ""
                    let frequencyOfTakingTheDrug = data["frequencyOfTakingTheDrug"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let remindType = data["remindType"] as? String ?? ""
                    let properties = data["properties"] as? String ?? ""
                    // Eğer ilaç tarihi bugünden önceyse, ilacı sil
                    if self.isDateBeforeToday(date) {
                        self.deleteMedicineNew(documentId, userId)
                        continue
                    }
                    
                    let medicine = Medicine(id: id, documentId: documentId, date: date, medicineName: medicineName, medicineType: medicineType, frequencyOfTakingTheDrug: frequencyOfTakingTheDrug, time: time, remindType: remindType, properties: properties)
                    
                    allMedicines.append(medicine)
                }
                
                // Tüm ilaçları güncelle
                self.medicines = allMedicines
            }
    }

    private func isDateBeforeToday(_ date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateObject = dateFormatter.date(from: date) else { return false }
        
        let today = Date()
        let currentDate = Calendar.current.startOfDay(for: today)
        let targetDate = Calendar.current.startOfDay(for: dateObject)
        
        return targetDate < currentDate
    }

    private func deleteMedicineNew(_ documentId: String, _ userId: String) {
        let db = Firestore.firestore()
        db.collection("ilaclar")
            .document(userId)
            .collection("ilacListesi")
            .document(documentId)
            .delete { error in
                if let error = error {
                    print("Error deleting document: \(error.localizedDescription)")
                } else {
                    print("Document successfully deleted")
                }
            }
    }

    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    //queryDocumentSnapshot.documentID
}
