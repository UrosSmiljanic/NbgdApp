//
//  ExpandableModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 05/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct Expandable: Codable {
    let status: Int?
    let entity: EntityExpandable?
    let message: JSONNull?
}

struct EntityExpandable: Codable {
    let file: String?
    let list: [ListExpandable]?
}

struct ListExpandable: Codable {
    let id, question, answer: String?
}

// MARK: Convenience initializers and mutators

extension Expandable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Expandable.self, from: data)
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
        entity: EntityExpandable?? = nil,
        message: JSONNull?? = nil
        ) -> Expandable {
        return Expandable(
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

extension EntityExpandable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityExpandable.self, from: data)
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
        file: String?? = nil,
        list: [ListExpandable]?? = nil
        ) -> EntityExpandable {
        return EntityExpandable(
            file: file ?? self.file,
            list: list ?? self.list
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension ListExpandable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ListExpandable.self, from: data)
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
        question: String?? = nil,
        answer: String?? = nil
        ) -> ListExpandable {
        return ListExpandable(
            id: id ?? self.id,
            question: question ?? self.question,
            answer: answer ?? self.answer
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

