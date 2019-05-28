//
//  FetchGenericData.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 12/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
    
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!) { (data, resp, err) in
        
        guard let data = data else { completion(nil, err); return }
        
        do {
            let obj = try JSONDecoder().decode(T.self, from: data)
            completion(obj, nil)
        } catch let jsonErr {
            print("Failed to decode json", jsonErr)
            completion(nil, jsonErr)
        }
        
        }.resume()
    
}

func fetchGenericDataGrid<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
    let url = URL(string: urlString)

    URLSession.shared.dataTask(with: url!) { (data, resp, err) in

        guard let data = data else { return }

        do {
            let obj = try JSONDecoder().decode(T.self, from: data)
            completion(obj)
        } catch let jsonErr {
            print("Failed to decode json", jsonErr)

        }

        }.resume()


}
