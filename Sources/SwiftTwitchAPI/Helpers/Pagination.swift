//
//  Pagination.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

class Paginated<WrappedType: Codable>: Codable {
    struct PaginationData: Codable {
        let cursor: String
    }

    let data: WrappedType
    let pagination: PaginationData?
}
