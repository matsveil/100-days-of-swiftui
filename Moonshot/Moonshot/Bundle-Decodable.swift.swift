//
//  Bundle-Decodable.swift.swift
//  Moonshot
//
//  Created by Matsvei Liapich on 1/23/26.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load \(file) in the bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in the bundle")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode due to a missing key: \(key), \(context)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failde to decode due to a type mismatch: \(context)")
        } catch DecodingError.valueNotFound(_, let context) {
            fatalError("Failed to decode due to a missing value: \(context)")
        } catch {
            fatalError("Failed to decode due to an error: \(error)")
        }
    }
}
