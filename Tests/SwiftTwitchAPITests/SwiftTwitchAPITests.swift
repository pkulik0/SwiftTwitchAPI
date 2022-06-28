import XCTest
@testable import SwiftTwitchAPI

class SwiftTwitchAPITests: XCTestCase {
    let api = SwiftTwitchAPI(clientID: "thffseh4mtlmaqnd89rm17ugso8s30", authToken: "8n137zor35bxuft3ymsapwe2xckx8u")
    
    func testGetChannels() throws {
        let expectation = XCTestExpectation(description: "exp")
        
        api.getChannel(broadcaster_ids: ["118350674"]) { result in
            switch(result) {
            case .success(let channels):
                XCTAssertFalse(channels.data.isEmpty)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    func testGetTopGames() throws {
        let expectation = XCTestExpectation(description: "exp")
    
        api.getTopGames { result in
            switch(result) {
            case .success(let paginatedGames):
                XCTAssert(paginatedGames.pagination?.cursor != nil)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
}
