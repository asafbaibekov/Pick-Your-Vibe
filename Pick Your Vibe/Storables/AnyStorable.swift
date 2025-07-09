//
//  AnyStorable.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//


final class AnyStorable<T>: Storable {
    typealias StoredType = T

    private let _save: (T?) async throws -> Void
    private let _load: () async throws -> T?

    init<S: Storable>(_ store: S) where S.StoredType == T {
        self._save = store.save
        self._load = store.load
    }

    func save(_ value: T?) async throws {
        try await _save(value)
    }

    func load() async throws -> T? {
        try await _load()
    }
}
