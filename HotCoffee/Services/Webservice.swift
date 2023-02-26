//
//  Webservice.swift
//  HotCoffee
//
//  Created by Toan Phan Nguyen Song on 23/02/2023.
//

import Foundation

struct Resource<T: Codable>{
    let url: URL
}

enum NetworkError: Error{
    case decodingError
    case domainError
    case urlError
}

struct Webservice{
    func load<T>(resource: Resource<T>,completion: @escaping (Result<T, NetworkError>)-> Void){
        URLSession.shared.dataTask(with: resource.url) { data, _, error in
            guard let data = data, error == nil else {
                    return
            }
            do{
                let data = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }catch {
                completion(.failure(.decodingError))
            }
        }
    }
}
