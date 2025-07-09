//
//  Storable.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//


protocol Storable {

    associatedtype StoredType

    func save(_ value: StoredType?) async throws

    func load() async throws -> StoredType?
}

extension Storable {

    func eraseToAnyStorable() -> AnyStorable<StoredType> {
        return AnyStorable(self)
    }
}
