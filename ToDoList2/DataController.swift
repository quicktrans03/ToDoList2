//
//  DataController.swift
//  PublicFile
//
//  Created by suhaihua on 2022/2/14.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ToDoList2")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Cannot load CoreData, because: \(error.localizedDescription)")
            }
        }
    }
}
