//
//  ContaactDetailsModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 14/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct ContactDetails: Codable {
    let status: Int
    let entity: EntityContactDetails
    let message: JSONNull?
}

struct EntityContactDetails: Codable {
    let id, email, phone: String
    let image: String
    let name, title, biography: String
}

// MARK: Convenience initializers and mutators

extension ContactDetails {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ContactDetails.self, from: data)
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
        entity: EntityContactDetails? = nil,
        message: JSONNull?? = nil
        ) -> ContactDetails {
        return ContactDetails(
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

extension EntityContactDetails {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityContactDetails.self, from: data)
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
        email: String? = nil,
        phone: String? = nil,
        image: String? = nil,
        name: String? = nil,
        title: String? = nil,
        biography: String? = nil
        ) -> EntityContactDetails {
        return EntityContactDetails(
            id: id ?? self.id,
            email: email ?? self.email,
            phone: phone ?? self.phone,
            image: image ?? self.image,
            name: name ?? self.name,
            title: title ?? self.title,
            biography: biography ?? self.biography
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

