//
//  SingleNewsModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 18/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct SingleNews: Codable {
    let status: Int
    let entity: EntitySingleNews
    let message: JSONNull?
}

struct EntitySingleNews: Codable {
    let id: String
    let image: String
    let publishDate, title: String
    let subtitle, introText: JSONNull?
    let text: String
    let relatedArticles: [RelatedArticle]
    
    enum CodingKeys: String, CodingKey {
        case id, image
        case publishDate = "publish_date"
        case title, subtitle
        case introText = "intro_text"
        case text
        case relatedArticles = "related_articles"
    }
}

struct RelatedArticle: Codable {
    let id: String
    let thumbnail: String
    let publishDate, title: String
    
    enum CodingKeys: String, CodingKey {
        case id, thumbnail
        case publishDate = "publish_date"
        case title
    }
}

// MARK: Convenience initializers and mutators

extension SingleNews {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SingleNews.self, from: data)
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
        entity: EntitySingleNews? = nil,
        message: JSONNull?? = nil
        ) -> SingleNews {
        return SingleNews(
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

extension EntitySingleNews {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntitySingleNews.self, from: data)
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
        image: String? = nil,
        publishDate: String? = nil,
        title: String? = nil,
        subtitle: JSONNull?? = nil,
        introText: JSONNull?? = nil,
        text: String? = nil,
        relatedArticles: [RelatedArticle]? = nil
        ) -> EntitySingleNews {
        return EntitySingleNews(
            id: id ?? self.id,
            image: image ?? self.image,
            publishDate: publishDate ?? self.publishDate,
            title: title ?? self.title,
            subtitle: subtitle ?? self.subtitle,
            introText: introText ?? self.introText,
            text: text ?? self.text,
            relatedArticles: relatedArticles ?? self.relatedArticles
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension RelatedArticle {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RelatedArticle.self, from: data)
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
        ) -> RelatedArticle {
        return RelatedArticle(
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
