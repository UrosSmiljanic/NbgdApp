//
//  GridIconModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct GridIconModel: Codable {
    let status: Int
    let entity: EntityGridIcon
    let message: JSONNull?
}

struct EntityGridIcon: Codable {
    let header: String?
    let title: String?
    let list: [ListGridIcon]
}

struct ListGridIcon: Codable {
    let id: String
    let objectID: String?
    let type: String
    let icon: String
    let image: JSONNull?
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case objectID = "object_id"
        case type, icon, image, title
    }
}

// MARK: Convenience initializers and mutators

extension GridIconModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GridIconModel.self, from: data)
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
        entity: EntityGridIcon? = nil,
        message: JSONNull?? = nil
        ) -> GridIconModel {
        return GridIconModel(
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

extension EntityGridIcon {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityGridIcon.self, from: data)
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
        header: String? = nil,
        title: String? = nil,
        list: [ListGridIcon]? = nil
        ) -> EntityGridIcon {
        return EntityGridIcon(
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

extension ListGridIcon {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ListGridIcon.self, from: data)
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
        objectID: String?? = nil,
        type: String? = nil,
        icon: String? = nil,
        image: JSONNull?? = nil,
        title: String? = nil
        ) -> ListGridIcon {
        return ListGridIcon(
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
