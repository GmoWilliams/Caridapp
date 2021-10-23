//
//  VerifyProductService.swift
//  Caridapp
//
//  Created by user196197 on 10/20/21.
//

import Foundation

enum APIError4:Error{
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest4 {
    let resourceURL: URL
    
    init (endpoint:String){
        let baseURL = "https://caridapp.herokuapp.com/\(endpoint)/"
        guard let resourceURL = URL (string: baseURL) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save(_ dataToSave:DonationVerification, completion: @escaping(Result<DonationVerification, APIError4>) -> Void){
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
            let encoder = JSONEncoder();

           
            urlRequest.httpBody = try encoder.encode(dataToSave)
            
            let task = URLSession.shared.dataTask(with: urlRequest){
                data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let JSONData =
                        data else {
                    completion(.failure(.responseProblem))
                    // Getting the servers Response for debugging
                    if let jsonResponse = String(data: data!, encoding: String.Encoding.utf8) {
                        print("JSON String: \(jsonResponse)")
                    }
                    
                    return
                }
            do {
                let decoder = JSONDecoder()
                let contentData = try decoder.decode(DonationVerification.self, from: JSONData)
                completion(.success(contentData))
            }catch{
                
                if let jsonResponse = String(data: data!, encoding: String.Encoding.utf8) {
                    print("JSON String: \(jsonResponse)")
                }
                completion(.failure(.decodingProblem))
                }
            }
            task.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
}

