//
//  ContentView.swift
//  CoreDataToDo
//
//  Created by Leandro Carvalho on 11/05/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var todoItem = ""
    @State private var setPriority = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        VStack {
            HStack {
                Text("My To Do's")
                    .font(.largeTitle)
                    .padding(.leading, 15)
                Spacer()
            }

            HStack {
                TextField("Enter a item", text: $todoItem)
                    .padding(.all, 2)
                    .font(Font.system(size: 25, design: .default))
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 15)
                Button(action: addItem) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }.padding(.trailing,15)
            }
            Picker(selection: $setPriority) {
                Text("Not in a rush").tag("🙂")
                Text("Important").tag("🧐")
                Text("Urgent").tag("🤯")
            } label: {
                Text("")
            }.pickerStyle(SegmentedPickerStyle())
                .padding(.leading, 15)
                .padding(.trailing, 15)
            
            NavigationView {
                List {
                    ForEach(items) { item in
                        ItemRowView(item: item.itemToDo ?? "Empty", creatAt: item.timestamp!, priority: item.priority ?? "Empty")
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.itemToDo = todoItem
            newItem.priority = setPriority

            do {
                try viewContext.save()
                todoItem = ""
                setPriority = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
