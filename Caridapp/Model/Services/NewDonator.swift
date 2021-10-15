//
//  NewDonator.swift
//  Caridapp
//
//  Created by user190824 on 10/15/21.
//

import Foundation


public class NewDonator {
    public typealias PublishDonatorClosure = (Data) -> Void
    
    public func publishDonator(Donator: Donator , _ handler: @escaping PublishDonatorClosure) {
        let publishDonatorEndpoint: String = "https://caridapp.herokuapp.com/setDonator"
        guard let url = URL(string: publishDonatorEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        let encoder = JSONEncoder();
        encoder.dateEncodingStrategy = .formatted(dateFormatter);
        //let decoder = JSONDecoder()
        let jsonData = try! encoder.encode(Donator)
        urlRequest.httpBody = jsonData
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on " + publishDonatorEndpoint)
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            if let jsonResponse = String(data: responseData, encoding: String.Encoding.utf8) {
                print("JSON String: \(jsonResponse)")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }
            
            handler(responseData)
        }
        task.resume()
    }
}
