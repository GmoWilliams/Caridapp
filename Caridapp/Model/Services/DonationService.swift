//
//  DonationService.swift
//  Caridapp
//
//  Created by user194082 on 10/9/21.
//

import Foundation

public class DonationService {
    public typealias PublishDonationClosure = (Data) -> Void
    
    public func publishDonation(donation: Donation , _ handler: @escaping PublishDonationClosure) {
        let publishDonationEndpoint: String = "https://caridapp-personal.herokuapp.com/setDonation"
        guard let url = URL(string: publishDonationEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        //let decoder = JSONDecoder()
        let jsonData = try! encoder.encode(donation)
        urlRequest.httpBody = jsonData
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on " + publishDonationEndpoint)
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
