//
//  NewDonator.swift
//  Caridapp
//
//  Created by user190824 on 10/15/21.
//

import Foundation

enum DonError:Error{
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct DonRequest {
    let resourceURL: URL
    
    init (endpoint:String){
        let baseURL = "https://caridapp.herokuapp.com/\(endpoint)/"
        guard let resourceURL = URL (string: baseURL) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save(_ dataToSave:Donator, completion: @escaping(Result<Donator, DonError>) -> Void){
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(dataToSave)
            
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
                let contentData = try JSONDecoder().decode(Donator.self, from: JSONData)
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
