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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        pagination = try? values.decode(PaginationData.self, forKey: .pagination)
        data = (try? values.decode([WrappedType].self, forKey: .data)) ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case data, pagination
    }
}
