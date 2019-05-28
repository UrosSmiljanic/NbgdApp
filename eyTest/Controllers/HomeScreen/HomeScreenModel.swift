//
//  HomeScreenModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct HomeScreenModel: Codable {
    let status: Int
    let entity: EntityHomeScreen
    let message: JSONNull?
}

struct EntityHomeScreen: Codable {
    let header, title: JSONNull?
    let list: [ListHomeScreen]
}

struct ListHomeScreen: Codable {
    let id: String
    let objectID: JSONNull?
    let type: String
    let icon: JSONNull?
    let image: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case objectID = "object_id"
        case type, icon, image, title
    }
}

// MARK: Convenience initializers and mutators

extension HomeScreenModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HomeScreenModel.self, from: data)
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
        entity: EntityHomeScreen? = nil,
        message: JSONNull?? = nil
        ) -> HomeScreenModel {
        return HomeScreenModel(
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

extension EntityHomeScreen {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityHomeScreen.self, from: data)
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
        title: JSONNull?? = nil,
        list: [ListHomeScreen]? = nil
        ) -> EntityHomeScreen {
        return EntityHomeScreen(
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

extension ListHomeScreen {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ListHomeScreen.self, from: data)
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
        objectID: JSONNull?? = nil,
        type: String? = nil,
        icon: JSONNull?? = nil,
        image: String? = nil,
        title: String? = nil
        ) -> ListHomeScreen {
        return ListHomeScreen(
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
