//
//  NewsListModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 18/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct NewsList: Codable {
    let status: Int
    let entity: EntityNewsList
    let message: JSONNull?
}

struct EntityNewsList: Codable {
    let list: [ListNewsList]
}

struct ListNewsList: Codable {
    let id: String
    let thumbnail: String?
    let publishDate, title: String
    
    enum CodingKeys: String, CodingKey {
        case id, thumbnail
        case publishDate = "publish_date"
        case title
    }
}

// MARK: Convenience initializers and mutators

extension NewsList {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NewsList.self, from: data)
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
        entity: EntityNewsList? = nil,
        message: JSONNull?? = nil
        ) -> NewsList {
        return NewsList(
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

extension EntityNewsList {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityNewsList.self, from: data)
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
        list: [ListNewsList]? = nil
        ) -> EntityNewsList {
        return EntityNewsList(
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

extension ListNewsList {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ListNewsList.self, from: data)
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
        title: String? = nil
        ) -> ListNewsList {
        return ListNewsList(
            id: id ?? self.id,
            thumbnail: thumbnail ?? self.thumbnail,
            publishDate: publishDate ?? self.publishDate,
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
