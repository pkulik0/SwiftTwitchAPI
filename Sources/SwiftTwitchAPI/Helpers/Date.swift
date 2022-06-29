//
//  Date.swift
//  
//
//  Created by pkulik0 on 29/06/2022.
//

struct DateRange: Codable {
    let endedAt: String
    let startedAt: String
    
    enum CodingKeys: String, CodingKey {
        case endedAt = "ended_at"
        case startedAt = "started_at"
    }
}
