//
//  GenericStore.swift
//  IsisMarketCoins
//
//  Created by Guilherme Silveira de Souza on 16/10/23.
//

import Foundation

protocol GenericStoreProtocol {
    var error: Error {get set}
    typealias completion<T> = (_ _result: T, _ failure: Error?) -> Void
}

class GenericStoreRquest: GenericStoreProtocol {
    
    var error = NSError(domain: "", code: 901, userInfo:
        [NSLocalizedDescriptionKey: "Error getting information"]) as Error
    
    func request<T: Codable>(url: URL, completion: @escaping completion<T?>){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, self, error)
                return
            }
            
            if let error {
                completion(nil, error)
                return
            }
            
            do{
                let objetc = try JSONDecoder().decode(T.self, from: data)
                completion(objetc, nil)
            }catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
