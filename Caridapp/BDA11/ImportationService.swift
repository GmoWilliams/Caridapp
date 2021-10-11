//
//  ImportationService.swift
//  Caridapp
//
//  Created by user190825 on 10/7/21.
//

import Foundation

enum APIError:Error{
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let resourceURL: URL
    
    init (endpoint:String){
        let baseURL = "https://caridapp.herokuapp.com/\(endpoint)/"
        guard let resourceURL = URL (string: baseURL) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save(_ dataToSave:Importation, completion: @escaping(Result<Importation, APIError>) -> Void){
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
                let contentData = try JSONDecoder().decode(Importation.self, from: JSONData)
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

class ImportationService {
    public typealias RetrieveHistoryClosure = ([Importation]) -> Void
    
    func retrieveHistory(_ handler: @escaping RetrieveHistoryClosure) {
            let historyEndpoint: String = "https://caridapp.herokuapp.com/history"
            guard let url = URL(string: historyEndpoint) else {
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
                    print("error calling GET on /history")
                    print(error!)
                    return
                }
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                do {
                    /*
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    */
 
                    if let jsonResponse = String(data: responseData, encoding: String.Encoding.utf8) {
                        print("JSON String: \(jsonResponse)")
                    }

                    let history = try decoder.decode([Importation].self, from: responseData)
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("statusCode: \(httpResponse.statusCode)")
                    }
                            
        
                    handler(history)
                } catch {
                    print("error trying to convert data to JSON")
                    return
                }

            }
            task.resume()
      }
}

