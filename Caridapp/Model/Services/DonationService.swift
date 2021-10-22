//
//  DonationService.swift
//  Caridapp
//
//  Created by user194082 on 10/9/21.
//

import Foundation

public class DonationService {
    public typealias PublishDonationClosure = () -> Void
    public typealias GetProductsClosure = ([Product]) -> Void
    
    public func publishDonation(donation: Donation , _ handler: @escaping PublishDonationClosure) {
        let publishDonationEndpoint: String = "https://caridapp.herokuapp.com/setDonation"
        guard let url = URL(string: publishDonationEndpoint) else {
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
            
            handler()
        }
        task.resume()
    }
    
    func getProducts (_ handler: @escaping GetProductsClosure) {
        let productsEndpoint : String = "https://caridapp.herokuapp.com/getTopProducts"
        guard let url = URL(string: productsEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let decoder = JSONDecoder()
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling GET on " + productsEndpoint)
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not recieve data")
                return
            }
            
            do {
                if let jsonResponse = String(data: responseData, encoding: String.Encoding.utf8) {
                    print("JSON String: " + jsonResponse)
                }
                
                let products = try decoder.decode([Product].self, from: responseData)
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode) ")
                }
                
                handler(products)
            } catch {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
}
