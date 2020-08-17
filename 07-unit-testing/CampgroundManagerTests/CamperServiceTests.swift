//
//  CamperServiceTests.swift
//  CampgroundManagerTests
//
//  Created by 변재우 on 20190130//.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
import CampgroundManager
import CoreData

class CamperServiceTests: XCTestCase {
	
	// MARK: Properties
	var camperService: CamperService!
	var coreDataStack: CoreDataStack!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
			super.setUp()
			
			coreDataStack = TestCoreDataStack()
			camperService = CamperService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
			
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
			
			camperService = nil
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
	
	func testAddCamper() {
		let camper = camperService.addCamper("Bacon Lover", phoneNumber: "910-543-9000")
		
		XCTAssertNotNil(camper, "Camper should not be nil")
		XCTAssertTrue(camper?.fullName == "Bacon Lover")
		XCTAssertTrue(camper?.phoneNumber == "910-543-9000")
		
	}
	
	func testRootContextIsSavedAfterAddingCamper() {
		//1
		let derivedContext = coreDataStack.newDerivedContext()
		camperService = CamperService(managedObjectContext: derivedContext, coreDataStack: coreDataStack)
		
		//2
		expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) { (notification) -> Bool in
			return true
		}
		
		//3
		derivedContext.perform {
			let camper = self.camperService.addCamper("Bacon Lover", phoneNumber: "910-543-9000")
			XCTAssertNotNil(camper)
		}
		
		//4
		waitForExpectations(timeout: 2.0) { (error) in
			XCTAssertNil(error, "Save did not occur")
		}
		
	}
	

}
