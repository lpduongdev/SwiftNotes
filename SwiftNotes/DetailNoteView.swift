//
//  DetailNoteView.swift
//  SwiftNotes
//
//  Created by Lương Dương on 19/09/2023.
//

import SwiftUI
import SwiftData

struct DetailNoteView: View {
    @Environment(\.modelContext) private var modelContext
    let noteId: String
    @State private var note: Note = Note(content: "", timestamp: Date())
    @FocusState private var isFocused: Bool

    init(noteId: String) {
        self.noteId = noteId
    }

    var body: some View {
        TextEditor(text: $note.content)
            .focused($isFocused)
            .onAppear {
                isFocused = true
                let predicate: Predicate = #Predicate<Note> { $0.id == noteId }
                let descriptor: FetchDescriptor = FetchDescriptor(predicate: predicate)
                if let note: Note = try? modelContext.fetch(descriptor).first {
                    self.note = note
                } else {
                    note = Note(content: "", timestamp: Date())
                }
            }
            .onChange(of: note) {
                updateItem()
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
            }
    }
    
    private func updateItem() {
        withAnimation {
            note.timestamp = Date()
            modelContext.processPendingChanges()
        }
    }
}

#Preview {
    DetailNoteView(noteId: "")
}
