//
//  Item.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

//* -> 현재 단계
// -> 코드 설명

import Foundation
import SwiftUI

//*  데이터(뷰에 전달할 수 있는)를 저장할 모델(Item)을 만든다.
// Item 타입을 따르는 각 데이터들을 식별할 수 있게 Identifiable 프로토콜을 준수하게 한다.
// JSON 파일과 데이터를 주고받고할 수 있게 Codable 프로토콜을 준수하게 한다.
struct Item: Identifiable, Codable {
    // 자동으로 UniqueID를 부여해주는 UUID를 사용해서 id 프로퍼티를 생성한다.
    var id: UUID = UUID()
    var url: URL
	var pointArray: [CGPoint]

	enum CodingKeys: CodingKey {
		case id, url, pointArray
	}

	init(id: UUID = UUID(), url: URL, pointArray: [CGPoint]) {
		self.id = id
		self.url = url
		self.pointArray = pointArray
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		url = try container.decode(URL.self, forKey: .url)
		pointArray = try container.decode([CGPoint].self, forKey: .pointArray)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(url, forKey: .url)
		try container.encode(pointArray, forKey: .pointArray)
	}
}


// lhs와 rhs를 비교하여 같은지 여부를 판단하는 함수로 Item을 확장한다.
extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
