//
//  ContentView.swift
//  ToDoList2
//
//  Created by suhaihua on 2022/2/16.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                NavigationView {
                    VStack {
                        Text("Unlocked")
                        
                        NavigationLink(destination: eontentView()) {
                            Text("View ->")
                                .foregroundColor(.red)
                        }
                    }
                }
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    
                }
            }
        } else {
            
        }
    }
}

struct eontentView: View {
    @FetchRequest(sortDescriptors:[]) var entitys: FetchedResults<Entity>
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(entitys) { entity in
                    VStack(alignment: .leading) {
                        Text(entity.name ?? "Unknown Title")
                            .font(.headline)
                        
                        Text(entity.content ?? "Unknown Author")
                            .foregroundColor(.secondary)
                    }
                }
                
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("PublicFile", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                showingSheet = true
            }) {
                Text("+")
            }.sheet(isPresented: $showingSheet) {
                EntityView()
            })
            
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = entitys[offset]
            moc.delete(book)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        eontentView()
    }
}
