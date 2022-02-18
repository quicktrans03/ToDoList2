//
//  EntityView.swift
//  ToDoList2
//
//  Created by suhaihua on 2022/2/16.
//

import SwiftUI

struct EntityView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var content = ""
    @State private var genre = ""

    let genres = ["Personal", "Business"]

    var body: some View {
        NavigationView {
            List {
                TextField("Name", text: $name)
                TextField("Content", text: $content)
                
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
                
                Button("Save") {
                    let newBook = Entity(context: moc)
                    newBook.id = UUID()
                    newBook.name = name
                    newBook.content = content
                    

                    try? moc.save()
                    dismiss()
                }
            }
            .navigationBarTitle("AddEntityView")
        }
    }
}

struct EntityView_Previews: PreviewProvider {
    static var previews: some View {
        EntityView()
    }
}
