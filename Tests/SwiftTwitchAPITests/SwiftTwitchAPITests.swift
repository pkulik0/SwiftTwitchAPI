import XCTest
@testable import SwiftTwitchAPI

class SwiftTwitchAPITests: XCTestCase {
    let api = SwiftTwitchAPI(clientID: "thffseh4mtlmaqnd89rm17ugso8s30", authToken: "bgort9x2teupqmob3m15m0kihqjld3")
    let testerID = "118350674"
    
    func testGetChannels() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getChannel(broadcasterIDs: [testerID]) { result in
            expectation.fulfill()
            switch(result) {
            case .success(let channels):
                XCTAssertFalse(channels.data.isEmpty)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testGetTopGames() throws {
        let expectation = XCTestExpectation(description: "api")
    
        api.getTopGames { result in
            expectation.fulfill()
            switch(result) {
            case .success(let paginatedGames):
                XCTAssert(paginatedGames.pagination?.cursor != nil)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testRunCommercial() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.runCommercial(broadcasterID: testerID, length: 60) { result in
            expectation.fulfill()
            switch(result) {
            case .success(let commercialResponse):
                XCTAssert(commercialResponse.data.first != nil)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testExtensionsAnalytics() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getExtensionsAnalytics { result in
            expectation.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testGameAnalytics() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getGamesAnalytics { result in
            expectation.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testBitsLeaderboard() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getBitsLeaderboard(userID: testerID) { result in
            expectation.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testBitsCheermotes() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getBitsCheermotes { result in
            expectation.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testModifyChannel() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.modifyChannel(broadcasterID: testerID, title: "title \(Int.random(in: 0...100))") { result in
            expectation.fulfill()
            switch(result) {
            case .success(let statusCode):
                XCTAssert(statusCode == 204)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testGetChannelEditors() throws {
        let expectation = XCTestExpectation(description: "api")
        
        api.getChannelEditors(broadcasterID: testerID) { result in
            expectation.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testChannelRewards() throws {
        var expectation = XCTestExpectation(description: "createReward")
        
        var rewardID: String?
        let rewardTitle = "test" + UUID().uuidString
        api.createChannelReward(broadcasterID: testerID, title: rewardTitle, cost: 999) { result in
            expectation.fulfill()
            switch(result) {
            case .success(let response):
                rewardID = response.data.first?.id
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 30.0)
        
        guard let rewardID = rewardID else {
            XCTFail("No reward was returned.")
            return
        }
        
        expectation = XCTestExpectation(description: "getRewards")
        api.getChannelRewards(broadcasterID: testerID) { result in
            expectation.fulfill()
            switch(result) {
            case .success(let result):
                XCTAssert(result.data.contains(where: { $0.id == rewardID }))
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
        
        expectation = XCTestExpectation(description: "removeReward")
        api.removeChannelReward(broadcasterID: testerID, rewardID: rewardID) { result in
            expectation.fulfill()
            switch(result) {
            case .success(let statusCode):
                XCTAssert(statusCode == 204)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
}
