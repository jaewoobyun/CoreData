//
//  ReservationServiceTests.swift
//  CampgroundManagerTests
//
//  Created by 변재우 on 20190130//.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
import Foundation
import CoreData
import CampgroundManager

class ReservationServiceTests: XCTestCase {
	
	// MARK: Properties
	var campSiteService: CampSiteService!
	var camperService: CamperService!
	var reservationService: ReservationService!
	var coreDataStack: CoreDataStack!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
			super.setUp()
			coreDataStack = TestCoreDataStack()
			camperService = CamperService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
			campSiteService = CampSiteService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
			reservationService = ReservationService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
			
    }

    override func tearDown() {
        super.tearDown()
			
			camperService = nil
			campSiteService = nil
			reservationService = nil
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
	
	func testReserveCampSitePositiveNumberOfDays() {
		let camper = camperService.addCamper("Johnny Appleseed", phoneNumber: "408-555-1234")!
		let campSite = campSiteService.addCampSite(15, electricity: false, water: false)
		
		let result = reservationService.reserveCampSite(campSite, camper: camper, date: Date(), numberOfNights: 5)
		
		XCTAssertNotNil(result.reservation, "Reservation should not be nil")
		XCTAssertNil(result.error, "No error should be present")
		XCTAssertTrue(result.reservation?.status == "Reserved", "Status should be Reserved")
	}
	
	func testReserveCampSiteNegativeNumberOfDays() {
		let camper = camperService.addCamper("Johnny Appleseed", phoneNumber: "408-555-1234")!
		let campSite = campSiteService.addCampSite(15, electricity: false, water: false)
		
		let result = reservationService!.reserveCampSite(campSite, camper: camper, date: Date(), numberOfNights: -1)
		
		XCTAssertNotNil(result.reservation, "Reservation should not be nil")
		XCTAssertNotNil(result.error, "An error should be present")
		XCTAssertTrue(result.error?.userInfo["Problem"] as? String == "Invalid number of days", "Error problem should be present")
		XCTAssertTrue(result.reservation?.status == "Invalid", "Status should be Invalid")
	}

}
