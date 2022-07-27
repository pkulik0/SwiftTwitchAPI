import XCTest
@testable import SwiftTwitchAPI

class SwiftTwitchAPITests: XCTestCase {
    let api = SwiftTwitchAPI(clientID: "thffseh4mtlmaqnd89rm17ugso8s30", authToken: "3184l994nsn2lgpq8gaup3oe3xifty")
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
    
    func testChannelGoals() throws {
        let expectation = XCTestExpectation(description: "getChannelGoals")
        
        api.getCreatorGoals(broadcasterID: testerID) { result in
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
    
    func testFindChannels() throws {
        let expectation = XCTestExpectation(description: "findChannels")
        
        api.findChannels(query: "a", showLiveOnly: false) { result in
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
    
    func testGetHypetrain() throws {
        let expectation = XCTestExpectation(description: "getHypetrain")
        
        api.getHypetrainInformation(broadcasterID: testerID) { result in
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
    
    func testCategories() throws {
        let expectation0 = XCTestExpectation(description: "getTopCategories")
        let expectation1 = XCTestExpectation(description: "getCategories")
        let expectation2 = XCTestExpectation(description: "findCategories")
    
        api.getTopCategories { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        api.getCategories(names: ["Minecraft"]) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        api.findCategories(query: "c") { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation2.fulfill()
        }
        
        wait(for: [expectation0, expectation1, expectation2], timeout: 30.0)
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
    
    func testBits() throws {
        let expectation1 = XCTestExpectation(description: "bitsLeaderboard")
        let expectation2 = XCTestExpectation(description: "bitsCheermotes")
        
        api.getBitsLeaderboard(userID: testerID) { result in
            expectation1.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        api.getBitsCheermotes { result in
            expectation2.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation1, expectation2], timeout: 30.0)
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
    
    func testRewards() throws {
        var expectation = XCTestExpectation(description: "createReward")
        
        var rewardID: String?
        let rewardTitle = "test" + UUID().uuidString
        let rewardPrice = Int.random(in: 1...10000000)
        api.createChannelReward(broadcasterID: testerID, title: rewardTitle, cost: rewardPrice) { result in
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
        
        expectation = XCTestExpectation(description: "updateReward")
        let prompt = "test" + UUID().uuidString
        api.updateChannelReward(broadcasterID: testerID, rewardID: rewardID, prompt: prompt) { result in
            expectation.fulfill()
            switch(result) {
            case .success(let result):
                XCTAssert(result.data.contains(where: { $0.prompt == prompt }))
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 30.0)
        
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
        
        expectation = XCTestExpectation(description: "getRedemptions")
        api.getChannelRewardRedemption(broadcasterID: testerID, rewardID: rewardID, status: .unfulfilled) { result in
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
    
    func testGetEmotes() throws {
        let expectation1 = XCTestExpectation(description: "getChannelEmotes")
        let expectation2 = XCTestExpectation(description: "getGlobalEmotes")
        
        var emoteSetID: String?
        
        api.getChannelEmotes(broadcasterID: testerID) { result in
            expectation1.fulfill()
            switch(result) {
            case .success(let response):
                emoteSetID = response.data.first?.emoteSetID
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        api.getGlobalEmotes { result in
            expectation2.fulfill()
            switch(result) {
            case .success(let result):
                XCTAssertFalse(result.data.isEmpty)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation1, expectation2], timeout: 30.0)
        
        guard let emoteSetID = emoteSetID else {
            XCTFail("No emotes received.")
            return
        }
        
        let expectation3 = XCTestExpectation(description: "getEmoteSet")
        api.getEmoteSets(emoteSetIDs: [emoteSetID]) { result in
            expectation3.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation3], timeout: 30.0)
    }
    
    func testGetBadges() throws {
        let expectation1 = XCTestExpectation(description: "getChannelBadges")
        let expectation2 = XCTestExpectation(description: "getGlobalBadges")
        
        api.getChannelBadges(broadcasterID: testerID) { result in
            expectation1.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        api.getGlobalBadges { result in
            expectation2.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation1, expectation2], timeout: 30.0)
    }
    
    func testChatSettings() throws {
        let expectation1 = XCTestExpectation(description: "getChatSettingsAsMod")
        let expectation2 = XCTestExpectation(description: "getChatSettings")
        let expectation3 = XCTestExpectation(description: "setChatSettings")

        api.getChatSettings(broadcasterID: testerID, moderatorID: testerID) { result in
            expectation1.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        api.getChatSettings(broadcasterID: testerID) { result in
            expectation2.fulfill()
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        api.updateChatSettings(broadcasterID: testerID, moderatorID: testerID, isInEmoteMode: true) { result in
            expectation3.fulfill()
            switch(result) {
            case .success(let response):
                guard let isInEmoteMode = response.data.first?.isInEmoteMode else {
                    XCTFail("Invalid response")
                    return
                }
                XCTAssert(isInEmoteMode)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation1, expectation2, expectation3], timeout: 30.0)
    }
    
    func testChatAnnouncement() throws {
        let expectation = XCTestExpectation(description: "chatAnnouncement")

        api.sendChatAnnouncement(broadcasterID: testerID, moderatorID: testerID, message: "Hello", color: .purple) { result in
            switch(result) {
            case .success(let statusCode):
                XCTAssert(statusCode == 204)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testChatColor() throws {
        var expectation = XCTestExpectation(description: "getChatColor")

        api.getChatColor(userIDs: [testerID]) { result in
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
        
        expectation = XCTestExpectation(description: "updateChatColor")
        api.updateChatColor(userID: testerID, color: .chocolate) { result in
            switch(result) {
            case .success(let statusCode):
                XCTAssert(statusCode == 204)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testClips() throws {
        let expectation0 = XCTestExpectation(description: "createClip")
        let expectation1 = XCTestExpectation(description: "getClips")
    
        api.createClip(broadcasterID: testerID) { result in
            switch(result) {
            case .success(let result):
                XCTAssert(result.data.first?.id != nil)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        
        api.getClips(broadcasterID: testerID) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        
        wait(for: [expectation0, expectation1], timeout: 30.0)
    }
    
    func testGetStreams() throws {
        let expectation0 = XCTestExpectation(description: "getStreams")
        let expectation1 = XCTestExpectation(description: "getFollowedStreams")

        api.getStreams(languages: ["en"]) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail("\(error.status) \(error.error) \(error.message)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        api.getFollowedStreams(userID: testerID) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail("\(error.status) \(error.error) \(error.message)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        
        wait(for: [expectation0, expectation1], timeout: 30.0)
    }
    
    func testTags() throws {
        let expectation0 = XCTestExpectation(description: "getAllTags")
        let expectation1 = XCTestExpectation(description: "getChannelTags")
        let expectation2 = XCTestExpectation(description: "updateChannelTags")

        api.getTags { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        api.getChannelTags(broadcasterID: testerID) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        api.updateChannelTags(broadcasterID: testerID, tagIDs: []) { result in
            switch(result) {
            case .success(let statusCode):
                XCTAssert(statusCode == 204)
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation2.fulfill()
        }
        wait(for: [expectation0, expectation1, expectation2], timeout: 30.0)
    }
    
    func testTeams() throws {
        let expectation0 = XCTestExpectation(description: "getChannelTeams")
        let expectation1 = XCTestExpectation(description: "getTeamInfo")
        
        api.getChannelTeams(broadcasterID: testerID) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        api.getTeamInformation(name: "esl") { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }

        wait(for: [expectation0, expectation1], timeout: 30.0)
    }
    
    func testUsers() throws {
        let expectation0 = XCTestExpectation(description: "getUsers")
        let expectation1 = XCTestExpectation(description: "updateUser")
        
        api.getUsers { result in
            switch(result) {
            case .success(let response):
                if let userData = response.data.first {
                    XCTAssert(userData.id == self.testerID)
                    break
                }
                XCTFail("No users were returned.")
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        
        api.updateCurrentUser(description: String(Int.random(in: 1...100))) { result in
            switch(result) {
            case .success(let response):
                if let userData = response.data.first {
                    XCTAssert(userData.id == self.testerID)
                    break
                }
                XCTFail("No users were returned.")
            case .failure(.serverError(error: let error)):
                XCTFail(error.message)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        
        wait(for: [expectation0, expectation1], timeout: 30.0)
    }
    
    func testFollows() throws {
        let expectation0 = XCTestExpectation(description: "getFollowsFromID")
        let expectation1 = XCTestExpectation(description: "getFollowsToID")
        
        api.getFollowsFromUser(userID: testerID) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail("\(error.status) \(error.error) \(error.message)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        
        api.getFollowsToUser(userID: testerID) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail("\(error.status) \(error.error) \(error.message)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        
        wait(for: [expectation0, expectation1], timeout: 30.0)
    }
    
    func testBlocklist() throws {
        let expectation0 = XCTestExpectation(description: "getBlocklist")
        let expectation1 = XCTestExpectation(description: "blockUser")
        let expectation2 = XCTestExpectation(description: "unblockUser")
        
        api.getUserBlocklist(userID: testerID) { result in
            switch(result) {
            case .success(_):
                break
            case .failure(.serverError(error: let error)):
                XCTFail("\(error.status) \(error.error) \(error.message)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        
        let targetUserID = "52406070"
        api.addUserToBlocklist(targetUserID: targetUserID) { result in
            switch(result) {
            case .success(let statusCode):
                XCTAssert(statusCode == 204)
            case .failure(.serverError(error: let error)):
                XCTFail("\(error.status) \(error.error) \(error.message)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        
        api.removeUserFromBlocklist(targetUserID: targetUserID) { result in
            switch(result) {
            case .success(let statusCode):
                XCTAssert(statusCode == 204)
            case .failure(.serverError(error: let error)):
                XCTFail("\(error.status) \(error.error) \(error.message)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation2.fulfill()
        }
        
        wait(for: [expectation0, expectation1, expectation2], timeout: 30.0)
    }
    
    func testTEmotes() throws {
        let expectation0 = XCTestExpectation(description: "AllGlobalEmotes")
        let expectation1 = XCTestExpectation(description: "AllChannelEmotes")


        api.getAllGlobalEmotes { result in
            switch(result) {
            case .success(_):
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation0.fulfill()
        }
        
        api.getAllChannelEmotes(channelID: "109027939") { result in
            switch(result) {
            case .success(_):
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation1.fulfill()
        }
        
        wait(for: [expectation0, expectation1], timeout: 30.0)
    }
}
