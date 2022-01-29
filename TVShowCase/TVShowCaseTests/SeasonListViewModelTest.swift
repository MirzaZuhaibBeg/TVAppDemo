//
//  SeasonListViewModelTest.swift
//  TVShowCaseTests
//
//  Created by Yasmin Tahira on 29/01/22.
//

import XCTest
@testable import TVShowCase

// MockAPIService class will be used to send mock data in place of original implementaion of APIServiceInteractor
class MockAPIService: APIServiceInteractor {
    
    func getSeasonInfoArray(withCompletionBlock completion: @escaping ServiceCompletionClosure) {
        completion(Data(), nil)
    }
}

// SeasonListMockView class will be used to receive delegate events instead of original view controller
class SeasonListMockView: SeasonListViewModelProtocol {
    
    var populateSeasonListDelegateCalled = false

    func populateSeasonList() {
        self.populateSeasonListDelegateCalled = true
    }
}

class SeasonListViewModelTest: XCTestCase {

    var sut: SeasonListViewModel?
    
    let viewMock = SeasonListMockView()

    override func setUpWithError() throws {
        
        // create view model with mock service object. mock service object will contain mocmdata instead of original data for testing
        sut = SeasonListViewModel(service: MockAPIService())
        
        // set viewMock as delegate instead of Season List View Controller so that delegate events can be received in mock view and tested
        sut?.attachView(view: viewMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetSeasonListt() {
        
        // call getSeasonList and test if mock service return correct data and delegate has been succesfully called in view controller
        self.sut?.getSeasonList()
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 0.5) {
            print(self.viewMock.populateSeasonListDelegateCalled)
            XCTAssertTrue(self.viewMock.populateSeasonListDelegateCalled)
        }
    }
}
