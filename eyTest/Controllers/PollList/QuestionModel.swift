//
//  QuestionModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 07/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct SingleSurvey: Codable {
    let status: Int
    let entity: SingleSurveyEntity
    let message: JSONNull?
}

struct SingleSurveyEntity: Codable {
    let name, date: String
    let options: [Option]
}

struct Option: Codable {
    let id, votes, option: String
}

// MARK: Convenience initializers and mutators

extension SingleSurvey {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SingleSurvey.self, from: data)
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
        entity: SingleSurveyEntity? = nil,
        message: JSONNull?? = nil
        ) -> SingleSurvey {
        return SingleSurvey(
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

extension SingleSurveyEntity {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SingleSurveyEntity.self, from: data)
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
        name: String? = nil,
        date: String? = nil,
        options: [Option]? = nil
        ) -> SingleSurveyEntity {
        return SingleSurveyEntity(
            name: name ?? self.name,
            date: date ?? self.date,
            options: options ?? self.options
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Option {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Option.self, from: data)
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
        votes: String? = nil,
        option: String? = nil
        ) -> Option {
        return Option(
            id: id ?? self.id,
            votes: votes ?? self.votes,
            option: option ?? self.option
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
