//
//  Sequence+AsyncMap.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-10.
//

import Foundation

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
