//
//  VerifyProductService.swift
//  Caridapp
//
//  Created by user196197 on 10/20/21.
//

import Foundation

enum APIError3:Error{
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest3 {
    let resourceURL: URL
    
    init (endpoint:String){
        let baseURL = "https://caridapp.herokuapp.com/\(endpoint)/"
        guard let resourceURL = URL (string: baseURL) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save(_ dataToSave:LineVerificaion, completion: @escaping(Result<LineVerificaion, APIError3>) -> Void){
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
            dateFormatter.timeZone = TimeZone(identifier:"GMT")
            let encoder = JSONEncoder();
            encoder.dateEncodingStrategy = .formatted(dateFormatter);
           
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
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
                dateFormatter.timeZone = TimeZone(identifier:"GMT")
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let contentData = try decoder.decode(LineVerificaion.self, from: JSONData)
                completion(.success(contentData))
            }catch{
                
                if let jsonResponse = String(data: data!, encoding: String.Encoding.utf8) {
                    print("JSON String: \(jsonResponse)")
                }
                /*  // Another way to get the servers Response
                let JSONResponse = String(data: JSONData, encoding: String.Encoding.utf8)
                print(JSONResponse!)
                */
                completion(.failure(.decodingProblem))
                }
            }
            task.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
}

