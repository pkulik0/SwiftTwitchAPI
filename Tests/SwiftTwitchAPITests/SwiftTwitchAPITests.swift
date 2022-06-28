import XCTest
@testable import SwiftTwitchAPI

class SwiftTwitchAPITests: XCTestCase {
    let api = SwiftTwitchAPI(clientID: "thffseh4mtlmaqnd89rm17ugso8s30", authToken: "8n137zor35bxuft3ymsapwe2xckx8u")
    let tester_id = "118350674"
    let panicOnScopeError = false
    
    func testGetChannels() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getChannel(broadcaster_ids: [tester_id]) { result in
            switch(result) {
            case .success(let channels):
                XCTAssertFalse(channels.data.isEmpty)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testGetTopGames() throws {
        let expectation = XCTestExpectation(description: "api")
    
        api.getTopGames { result in
            switch(result) {
            case .success(let paginatedGames):
                XCTAssert(paginatedGames.pagination?.cursor != nil)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testRunCommercial() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.runCommercial(broadcaster_id: tester_id, length: 60) { result in
            switch(result) {
            case .success(let commercialResponse):
                XCTAssert(commercialResponse.data.first != nil)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testExtensionsAnalytics() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getExtensionsAnalytics { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testGameAnalytics() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getGamesAnalytics { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testBitsLeaderboard() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getBitsLeaderboard(user_id: "109027939") { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testBitsCheermotes() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getBitsCheermotes { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
}
