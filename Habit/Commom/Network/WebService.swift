//
//  WebService.swift
//  Habit
//
//  Created by Rogério Júnior on 03/03/23.
//

import Foundation


enum WebService {
    /*
     {"name": "string","email": "string", "document": "string", "phone": "string", "gender": 0, "birthday": "2023-03-03", "password": "string"}
     */
    
    enum EndPoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        
        case postUser = "/users"
    }
    
    private static func completeUrl(path: EndPoint) -> URLRequest? {
        guard let url =  URL(string: "\(EndPoint.base.rawValue)\(path.rawValue)") else { return nil }
        
                return URLRequest(url: url)
    }
    
    static func postUser(fullName: String,
                         email: String,
                         password: String,
                         document: String,
                         phone: String,
                         birthday: String,
                         gender: Int){
        
        let json: [String : Any] = [
            "name": fullName,
            "email": email,
            "document": document,
            "phone": phone,
            "gender": gender,
            "birthday": birthday,
            "password": password
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard var urlRequest = completeUrl(path: .postUser) else { return }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            print(String(data: data, encoding: .utf8))
            
            print("response\n")
            
            print(response)
            
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
        }
        
        task.resume()
    }
    
}
