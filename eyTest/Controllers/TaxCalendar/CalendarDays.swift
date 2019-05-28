//
//  CalendarDays.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 11/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct CalendarDays: Codable {
    let status: Int?
    let entity: [String]?
    let message: JSONNull?
}

// MARK: Convenience initializers and mutators

extension CalendarDays {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CalendarDays.self, from: data)
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
        entity: [String]?? = nil,
        message: JSONNull?? = nil
        ) -> CalendarDays {
        return CalendarDays(
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
