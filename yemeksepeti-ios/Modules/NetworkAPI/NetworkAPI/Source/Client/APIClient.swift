//
//  APIClient.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//
import UIKit

public extension Foundation.Notification.Name {
    static let didReceive401 = Foundation.Notification.Name("didReceiveUnauthorizedError")
}

public final class APIClient {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    
    private var session: URLSession = URLSession.shared
    private var unauthorizedNotification = Foundation.Notification(name: .didReceive401)
    
    public static var shared = APIClient()
    
    public func request<T>(responseType: T.Type, router: Routable, completion: @escaping (APIResponse<T>) -> ()) where T: Decodable {
        
        let request = URLRequest(router: router)
        
        let task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
            }
        })
        task.resume()
    }
    
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (APIResponse<T>) -> ()) {
        
        guard error == nil else { 
            if let nsError = error as NSError?, nsError.code == -1009 {
                //                Loading.shared.hide()
                return completion(.failure(.unknown))
            }
            return completion(.failure(.unknown)) 
        }
        
        guard let response = response else { return completion(.failure(.noJSONData)) }
        
        if response.statusCode == 401 {
            NotificationCenter.default.post(unauthorizedNotification)
        }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data else { return completion(.failure(.unknown)) }
            
            do {
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(decodedObject))
                
                
            } catch let error {
                return completion(.failure(.decodingError(error)))
            }
        case 400...599:
            guard let data = data else { return completion(.failure(.unknown)) }
            
            do {
                return completion(.failure(.unknown))
                
            } catch let error {
                return completion(.failure(.decodingError(error)))
            }
        default:
            completion(.failure(.unknown))
        }
        
    }
    
    func requestWithoutData<T>(responseType: T.Type, router: Routable, completion: @escaping (APIResponse<T>) -> ()) where T: Decodable {
        
        let request = URLRequest(router: router)
        
        let task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                //                self?.handleDataResponseWithout(data: data, response: httpResponse, error: error, completion: completion)
            }
        })
        print(request.cURL)
        task.resume()
    }
}

