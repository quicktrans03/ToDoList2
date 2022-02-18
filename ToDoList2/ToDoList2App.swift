//
//  ToDoList2App.swift
//  ToDoList2
//
//  Created by suhaihua on 2022/2/16.
//

import SwiftUI

@main
struct ToDoList2App: App {
    let dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
