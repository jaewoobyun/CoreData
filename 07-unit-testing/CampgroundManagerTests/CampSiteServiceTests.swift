//
//  CampSiteServiceTests.swift
//  CampgroundManagerTests
//
//  Created by 변재우 on 20190130//.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
import UIKit
import CampgroundManager
import CoreData

class CampSiteServiceTests: XCTestCase {
	
	// MARK: Properties
	var campSiteService: CampSiteService!
	var coreDataStack: CoreDataStack!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
			super.setUp()
			
			coreDataStack = TestCoreDataStack()
			campSiteService = CampSiteService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
			
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
			
			campSiteService = nil
			coreDataStack = nil
    }

//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
	
	func testAddCampSite() {
		let campSite = campSiteService.addCampSite(1, electricity: true, water: true)
		
		XCTAssertTrue(campSite.siteNumber == 1, "Site number should be 1")
		XCTAssertTrue(campSite.electricity!.boolValue, "Site should have electricity")
		XCTAssertTrue(campSite.water!.boolValue, "Site should have water")
	}
	
	func testRootContextIsSavedAfterAddingCampsite() {
		let derivedContext = coreDataStack.newDerivedContext()
		
		campSiteService = CampSiteService(managedObjectContext: derivedContext, coreDataStack: coreDataStack)
		
		expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) { (notification) -> Bool in
			return true
		}
		
		derivedContext.perform {
			let campSite = self.campSiteService.addCampSite(1, electricity: true, water: true)
			XCTAssertNotNil(campSite)
			
		}
		
		waitForExpectations(timeout: 2.0) { (error) in
			XCTAssertNil(error, "Save did not occur")
		}
		
	}
	
	func testGetCampSiteWithMatchingSiteNumber() {
		_ = campSiteService.addCampSite(1, electricity: true, water: true)
		
		let campSite = campSiteService.getCampSite(1)
		XCTAssertNotNil(campSite, "A campsite should be returned")
	}
	
	func testGetCampSiteNoMatchingSiteNumber() {
		_ = campSiteService.addCampSite(1, electricity: true, water: true)
		
		let campSite = campSiteService.getCampSite(2)
		XCTAssertNil(campSite, "No campsite should be returned")
	}
	
	func testCampSiteNoSites(){
		let campSite = campSiteService?.getCampSite(1)
		XCTAssertNil(campSite, "No campsite should be returned")
	}
	
	func testGetCampSitesNoSites() {
		let site = campSiteService?.getCampSites()
		XCTAssertTrue(site?.count == 0, "There should be no sites")
	}
	
	func testGetCampSitesOneSite() {
		_ = campSiteService.addCampSite(1, electricity: true, water: true)
		let sites = campSiteService.getCampSites()
		XCTAssertTrue(sites.count == 1 , "There should be one site")
	}
	
	func testGetCampSitesMultipleSite() {
		_ = campSiteService.addCampSite(1, electricity: true, water: true)
		_ = campSiteService.addCampSite(2, electricity: true, water: false)
		
		let sites = campSiteService.getCampSites()
		
		XCTAssertTrue(sites.count > 1, "There are more than one sites")
	}
	
	func testDeleteCampSite() {
		_ = campSiteService.addCampSite(1, electricity: true, water: true)
//		_ = campSiteService.addCampSite(2, electricity: true, water: false)
		
		var fetchedCampSite = campSiteService.getCampSite(1)
		
		XCTAssertNotNil(fetchedCampSite, "Site should exist")
		
		campSiteService.deleteCampSite(1)
		
		fetchedCampSite = campSiteService.getCampSite(1)
		
		XCTAssertNil(fetchedCampSite, "Site should not exist")
		
	}
	
	func testGetNextCampSiteNumberNoSites() {
		let siteNumber = campSiteService.getNextCampSiteNumber()
		
		XCTAssertTrue(siteNumber == 1, "This should be the first camp site number")
	}
	
	func testGetNextCampSiteNumberOneSite() {
		_ = campSiteService.addCampSite(1, electricity: true, water: true)

		let siteNumber = campSiteService.getNextCampSiteNumber()
		
		XCTAssertTrue(siteNumber == 2, "This should be the second site number")
	}
	
	func testGetNextCampSiteNumberOneSiteGapFrom1() {
		_ = campSiteService.addCampSite(10, electricity: true, water: true)
		
		let siteNumber = campSiteService.getNextCampSiteNumber()
		
		XCTAssertTrue(siteNumber == 11, "This should be the second site number")
	}
	
	func testGetNextCampSiteNumberMultipleSites() {
		_ = campSiteService.addCampSite(3, electricity: true, water: true)
		_ = campSiteService.addCampSite(4, electricity: true, water: true)
		
		let siteNumber = campSiteService.getNextCampSiteNumber()
		
		XCTAssertTrue(siteNumber == 5, "This should be the next site number")
	}

}
