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

    let data: [WrappedType]
    let pagination: PaginationData?
    let total: Int?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        pagination = try? values.decode(PaginationData.self, forKey: .pagination)
        data = (try? values.decode([WrappedType].self, forKey: .data)) ?? []
        total = try? values.decode(Int.self, forKey: .total)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, pagination, total
    }
}
