//
//  Pagination.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

public class Paginated<WrappedType: Codable>: Codable {
    public struct PaginationData: Codable {
        let cursor: String
    }

    public let data: [WrappedType]
    public let pagination: PaginationData?
    public let total: Int?
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        pagination = try? values.decode(PaginationData.self, forKey: .pagination)
        data = (try? values.decode([WrappedType].self, forKey: .data)) ?? []
        total = try? values.decode(Int.self, forKey: .total)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, pagination, total
    }
}
