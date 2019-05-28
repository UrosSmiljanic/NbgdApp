//
//  EyEventsFiltered.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 21/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct EuEventsList: Codable {
    let status: Int
    let entity: EuEventsListEntity
    let message: JSONNull?
}

struct EuEventsListEntity: Codable {

    let completed: [Completed]
}

struct Completed: Codable {
    let id: String
    let thumbnail: String
    let publishDate, startDate, endDate, title: String
    let active: String

    enum CodingKeys: String, CodingKey {
        case id, thumbnail
        case publishDate = "publish_date"
        case startDate = "start_date"
        case endDate = "end_date"
        case title, active
    }
}

// MARK: Convenience initializers and mutators

extension EuEventsList {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EuEventsList.self, from: data)
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
        entity: EuEventsListEntity? = nil,
        message: JSONNull?? = nil
        ) -> EuEventsList {
        return EuEventsList(
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

extension EuEventsListEntity {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EuEventsListEntity.self, from: data)
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

        completed: [Completed]? = nil
        ) -> EuEventsListEntity {
        return EuEventsListEntity(

            completed: completed ?? self.completed
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Completed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Completed.self, from: data)
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
        thumbnail: String? = nil,
        publishDate: String? = nil,
        startDate: String? = nil,
        endDate: String? = nil,
        title: String? = nil,
        active: String? = nil
        ) -> Completed {
        return Completed(
            id: id ?? self.id,
            thumbnail: thumbnail ?? self.thumbnail,
            publishDate: publishDate ?? self.publishDate,
            startDate: startDate ?? self.startDate,
            endDate: endDate ?? self.endDate,
            title: title ?? self.title,
            active: active ?? self.active
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


