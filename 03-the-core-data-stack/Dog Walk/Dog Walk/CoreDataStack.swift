//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by 변재우 on 20190125//.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
	
	private let modelName: String
	
	lazy var managedContenxt: NSManagedObjectContext = {
		return self.storeContainer.viewContext
	}()
	
	init(modelName: String) {
		self.modelName = modelName
	}
	
	private lazy var storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: self.modelName)
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	func saveContext() {
		guard managedContenxt.hasChanges else { return }
		
		do {
			try managedContenxt.save()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
		}
		
		
	}
	
	
}
