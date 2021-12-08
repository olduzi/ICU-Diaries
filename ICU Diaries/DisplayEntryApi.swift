//
//  DisplayEntryApi.swift
//  ICU Diaries
//
//  Created by Simran  Chowdhry on 11/14/21.
//

import Foundation
import SwiftUI

struct FetchEntryResponse : Codable {
    var contents:[Entry]
}

struct FetchEntriesRequest : Codable {
    var user_id: Int
    var date: String
}

class DisplayEntry : ObservableObject{
    
    func allEntries(entry: FetchEntriesRequest, completion:@escaping ([Entry]) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/diary/receiver/?user_id=\(entry.user_id)&date=\(entry.date)") else {
            print("Invalid url...")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
                let response = try! JSONDecoder().decode(FetchEntryResponse.self, from: data!)
                guard let data = data else { return }
                let _ = print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                completion(response.contents)
            }
        }.resume()
    }
    
    func single(diary_id: Int, completion:@escaping ([Entry]) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/diary/single?diary_id=\(diary_id)") else {
            print("Invalid url...")
            return
        }
 
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let response = try! JSONDecoder().decode(FetchEntryResponse.self, from: data!)
            guard let data = data else { return }
            let _ = print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                completion(response.contents)
            }
        }.resume()
    }
    
    func updateEntry(entry: Entry, completion:@escaping (String) -> ()) {
            guard let url = URL(string: "http://68.58.243.157:8000/api/diary/update/") else {
                print("Invalid url...")
                return
            }

        let body: [String : Any] = ["diary_id": entry.diary_id, "sender_id": entry.sender_id, "receiver_id": entry.receiver_id, "new_title": entry.title, "new_content": entry.content]
            let finalBody = try! JSONSerialization.data(withJSONObject: body)

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Accept", forHTTPHeaderField: "Vary")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    completion(response!.description)
                }
            }.resume()
    }
}

// Date extension
extension Date {
  static func getStringFromDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    let dateString = dateFormatter.string(from: date)
    return dateString
  }
  static func getDateFromString(dateString: String) -> Date? {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime,
                               .withDashSeparatorInDate,
                               .withFullDate,
                               .withFractionalSeconds,
                               .withColonSeparatorInTimeZone]
    guard let date = formatter.date(from: dateString) else {
      return nil
    }
    return date
  }
  // get an ISO timestamp
    static func getISOTimestamp(date: Date) -> String {
    let isoDateFormatter = ISO8601DateFormatter()
    let timestamp = isoDateFormatter.string(from: date)
        return String(timestamp.prefix(10))
  }
}

struct DisplayEntryTest: View {
    @State var entries = FetchEntriesRequest(user_id: 6, date: "2021-11-09")
    @State var content = 0

    var body: some View {
        Text("\(content)")
            .onAppear() {
                DisplayEntry().allEntries(entry: entries) { (entries) in
                    self.content = entries[0].diary_id
                }
                }.navigationTitle("Quote List")
        }
}

struct DisplayEntry_Previews: PreviewProvider {
    static var previews: some View {
        DisplayEntryTest()
    }
}
