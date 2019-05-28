//
//  GridContactModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 21/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct GridContact: Codable {
    let status: Int?
    let entity: EntityGridContact?
    let message: JSONNull?
}

struct EntityGridContact: Codable {
    let header: JSONNull?
    let title: String?
    let list: [ListGridContact]?
}

struct ListGridContact: Codable {
    let id, objectID, type: String?
    let icon: JSONNull?
    let image: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case objectID = "object_id"
        case type, icon, image, title
    }
}

// MARK: Convenience initializers and mutators

extension GridContact {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GridContact.self, from: data)
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
        entity: EntityGridContact?? = nil,
        message: JSONNull?? = nil
        ) -> GridContact {
        return GridContact(
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

extension EntityGridContact {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityGridContact.self, from: data)
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
        header: JSONNull?? = nil,
        title: String?? = nil,
        list: [ListGridContact]?? = nil
        ) -> EntityGridContact {
        return EntityGridContact(
            header: header ?? self.header,
            title: title ?? self.title,
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

extension ListGridContact {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ListGridContact.self, from: data)
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
        objectID: String?? = nil,
        type: String?? = nil,
        icon: JSONNull?? = nil,
        image: String?? = nil,
        title: String?? = nil
        ) -> ListGridContact {
        return ListGridContact(
            id: id ?? self.id,
            objectID: objectID ?? self.objectID,
            type: type ?? self.type,
            icon: icon ?? self.icon,
            image: image ?? self.image,
            title: title ?? self.title
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
