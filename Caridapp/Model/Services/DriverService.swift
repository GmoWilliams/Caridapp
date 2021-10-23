//
//  DriverService.swift
//  Caridapp
//
//  Created by user194082 on 10/22/21.
//

import Foundation

public class DriverService {
    public typealias GetDonationsClosure = ([DonationDriver]) -> Void
    public typealias UpdateDonationStatusClosure = () -> Void

    public func getDonations(_ handler: @escaping GetDonationsClosure) {
        let donationsEndpoint : String = "https://caridapp.herokuapp.com/getDonations"
        guard let url = URL(string: donationsEndpoint) else {
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
                print("error calling GET on " + donationsEndpoint)
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

                let donations = try decoder.decode([DonationDriver].self, from: responseData)

                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                }

                handler(donations)
            } catch {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    public func updateDonationStatus(donation: DonationDriver, _ handler: @escaping UpdateDonationStatusClosure){
        let updateDonationStatusEndpoint: String = "https://caridapp.herokuapp.com/updateDonationStatus"
        guard let url = URL(string: updateDonationStatusEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder();
        let jsonData = try! encoder.encode(donation)
        urlRequest.httpBody = jsonData
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            guard error == nil else {
                print("error calling PUT on " + updateDonationStatusEndpoint)
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not recieve data")
                return
            }
            
            if let jsonResponse = String(data: responseData, encoding: String.Encoding.utf8) {
                print("JSON StringL \(jsonResponse)")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }
            
            handler()
        }
        task.resume()
        
    }
}
