//
//  UpdateProductService.swift
//  Caridapp
//
//  Created by user190825 on 10/18/21.
//
import Foundation

enum APIError2:Error{
    case responseProblem
    case decodingProblem
    case encodingProblem
}

class APIRequest2 {
    
    let resourceURL: URL
    init (endpoint:String){
        let baseURL = "https://caridapp.herokuapp.com/\(endpoint)/"
        // We must be sure there is a value created for URL before continuing
        guard let resourceURL = URL (string: baseURL) else {fatalError()}

        self.resourceURL = resourceURL
    }
    
    // MARK: - UPDATING FUNCTION
    func save(_ dataToSave:LineUpdate, completion: @escaping(Result<LineUpdate, APIError2>) -> Void){
        do{
            var urlRequest = URLRequest(url: resourceURL)
            // This operation must be from PUT method
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // We must specify the correct format that DB is currently managing
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
            dateFormatter.timeZone = TimeZone(identifier:"GMT")
            let encoder = JSONEncoder();
            encoder.dateEncodingStrategy = .formatted(dateFormatter);
            
            // We encode our data into JSON object
            urlRequest.httpBody = try encoder.encode(dataToSave)
            
            let task = URLSession.shared.dataTask(with: urlRequest){
                data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    // If server responds with an "OK" code
                    httpResponse.statusCode == 200, let JSONData =
                        data else {
                    // Otherwise we notify endpoint is not responding
                    completion(.failure(.responseProblem))
                    
                    if let jsonResponse = String(data: data!, encoding: String.Encoding.utf8) {
                        print("JSON String: \(jsonResponse)")
                    }
                    
                    return
                }
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                dateFormatter.timeZone = TimeZone(identifier:"GMT")
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                // If we can decode the JSON, sent data process was successful
                let contentData = try decoder.decode(LineUpdate.self, from: JSONData)
                completion(.success(contentData))
            }catch{
                
                if let jsonResponse = String(data: data!, encoding: String.Encoding.utf8) {
                    print("JSON String: \(jsonResponse)")
                }
                
                // Otherwise we print the type of result for debugging
                
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
