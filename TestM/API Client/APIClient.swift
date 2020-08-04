//
//  APIClient.swift
//  TestM
//
//  Created by GS on 03/08/20.
//  Copyright © 2020 Gaurishankar Vibhute. All rights reserved.
//

import Foundation


class APIClient {
    func frtchpicsumdata(complition: @escaping ([PicsumModel]) -> Void) {
        
        let session = URLSession.shared
        let url = URL(string: "https://picsum.photos/list")!
        

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {

                let decoder = JSONDecoder()
                let model = try decoder.decode([PicsumModel].self, from:
                    data!) //Decode JSON Response Data
//                print(model)
                complition(model)
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
