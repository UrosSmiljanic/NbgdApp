//
//  TaxNewsletterModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 20/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct TaxNewsletterModel: Codable {
    let status: Int
    let entity: [EntityTaxNewsletterModel]
    let message: JSONNull?
}

struct EntityTaxNewsletterModel: Codable {
    let id, title, publishDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case publishDate = "publish_date"
    }
}

// MARK: Convenience initializers and mutators

extension TaxNewsletterModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TaxNewsletterModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        status: Int? = nil,
        entity: [EntityTaxNewsletterModel]? = nil,
        message: JSONNull?? = nil
        ) -> TaxNewsletterModel {
        return TaxNewsletterModel(
            status: status ?? self.status,
            entity: entity ?? self.entity,
            message: message ?? self.message
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension EntityTaxNewsletterModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityTaxNewsletterModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: String? = nil,
        title: String? = nil,
        publishDate: String? = nil
        ) -> EntityTaxNewsletterModel {
        return EntityTaxNewsletterModel(
            id: id ?? self.id,
            title: title ?? self.title,
            publishDate: publishDate ?? self.publishDate
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: Encode/decode helpers

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

