//
//  IntroPagesModelSr.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct IntroPagesSr: Codable {
    let status: Int?
    let entity: EntityIntroPagesSr?
    let message: JSONNull?
}

struct EntityIntroPagesSr: Codable {
    let mobIntroAppSr, mobIntroPushSr, mobIntroTermsSr: String?

    enum CodingKeys: String, CodingKey {
        case mobIntroAppSr = "mob_intro_app_sr"
        case mobIntroPushSr = "mob_intro_push_sr"
        case mobIntroTermsSr = "mob_intro_terms_sr"
    }
}

// MARK: Convenience initializers and mutators

extension IntroPagesSr {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IntroPagesSr.self, from: data)
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
        status: Int?? = nil,
        entity: EntityIntroPagesSr?? = nil,
        message: JSONNull?? = nil
        ) -> IntroPagesSr {
        return IntroPagesSr(
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

extension EntityIntroPagesSr {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityIntroPagesSr.self, from: data)
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
        mobIntroAppSr: String?? = nil,
        mobIntroPushSr: String?? = nil,
        mobIntroTermsSr: String?? = nil
        ) -> EntityIntroPagesSr {
        return EntityIntroPagesSr(
            mobIntroAppSr: mobIntroAppSr ?? self.mobIntroAppSr,
            mobIntroPushSr: mobIntroPushSr ?? self.mobIntroPushSr,
            mobIntroTermsSr: mobIntroTermsSr ?? self.mobIntroTermsSr
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
