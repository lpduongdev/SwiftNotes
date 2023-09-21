//
//  ContentView.swift
//  SwiftNotes
//
//  Created by Lương Dương on 19/09/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.timestamp, order: .reverse) private var items: [Note]

    var body: some View {
        NavigationSplitView {
            List {
                if items.isEmpty {
                    Text("No record found!")
                } else {
                    ForEach(items) { item in
                        NavigationLink {
                            DetailNoteView(noteId: item.id)
                                .modelContext(modelContext)
                        } label: {
                            HStack {
                                if item.content.isEmpty {
                                    Text("New note")
                                } else {
                                    Text(item.content)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .none))
                                    Text(item.timestamp, format: Date.FormatStyle(date: .none, time: .shortened))
                                }
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Note(content: "", timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
}
