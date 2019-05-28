//
//  SingleEventModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 04/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct SingleEvent: Codable {
    let status: Int?
    let entity: EntitySingleEvent?
    let message: JSONNull?
}

struct EntitySingleEvent: Codable {
    let id: String?
    let image: String?
    let publishDate, startDate, endDate, title: String?
    let subtitle: String?
    let introText, text: String?

    enum CodingKeys: String, CodingKey {
        case id, image
        case publishDate = "publish_date"
        case startDate = "start_date"
        case endDate = "end_date"
        case title, subtitle
        case introText = "intro_text"
        case text
    }
}

// MARK: Convenience initializers and mutators

extension SingleEvent {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SingleEvent.self, from: data)
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
        entity: EntitySingleEvent?? = nil,
        message: JSONNull?? = nil
        ) -> SingleEvent {
        return SingleEvent(
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

extension EntitySingleEvent {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntitySingleEvent.self, from: data)
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
        id: String?? = nil,
        image: String?? = nil,
        publishDate: String?? = nil,
        startDate: String?? = nil,
        endDate: String?? = nil,
        title: String?? = nil,
        subtitle: String?? = nil,
        introText: String?? = nil,
        text: String?? = nil
        ) -> EntitySingleEvent {
        return EntitySingleEvent(
            id: id ?? self.id,
            image: image ?? self.image,
            publishDate: publishDate ?? self.publishDate,
            startDate: startDate ?? self.startDate,
            endDate: endDate ?? self.endDate,
            title: title ?? self.title,
            subtitle: subtitle ?? self.subtitle,
            introText: introText ?? self.introText,
            text: text ?? self.text
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
