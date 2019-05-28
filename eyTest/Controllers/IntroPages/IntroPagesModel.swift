//
//  IntroPagesModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 12/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct IntroPagesModel: Codable {
    let status: Int
    let entity: Entity
    let message: JSONNull?
}

struct Entity: Codable {
    let mobIntroAppEn, mobIntroPushEn, mobIntroTermsEn: String
    
    enum CodingKeys: String, CodingKey {
        case mobIntroAppEn = "mob_intro_app_en"
        case mobIntroPushEn = "mob_intro_push_en"
        case mobIntroTermsEn = "mob_intro_terms_en"
    }
}

// MARK: Convenience initializers and mutators

extension IntroPagesModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IntroPagesModel.self, from: data)
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
        entity: Entity? = nil,
        message: JSONNull?? = nil
        ) -> IntroPagesModel {
        return IntroPagesModel(
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

extension Entity {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Entity.self, from: data)
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
        mobIntroAppEn: String? = nil,
        mobIntroPushEn: String? = nil,
        mobIntroTermsEn: String? = nil
        ) -> Entity {
        return Entity(
            mobIntroAppEn: mobIntroAppEn ?? self.mobIntroAppEn,
            mobIntroPushEn: mobIntroPushEn ?? self.mobIntroPushEn,
            mobIntroTermsEn: mobIntroTermsEn ?? self.mobIntroTermsEn
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

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

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
