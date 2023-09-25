//
//  IRepository.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 14.09.2023.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype Entity

    func create(entity: Entity) throws
    func read(id: UUID) -> Entity?
    func readAll() -> [Entity]
    func update(entity: Entity) throws
    func delete(entity: Entity) throws
}

protocol EntityProtocol {
    associatedtype StoreType: StorableProtocol

    func toStorable() -> StoreType
}

protocol StorableProtocol {
    associatedtype EntityObject: EntityProtocol

    var model: EntityObject { get }
    var id: UUID { get }
}
