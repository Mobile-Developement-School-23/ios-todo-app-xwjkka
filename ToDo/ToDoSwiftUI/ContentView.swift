//
//  ContentView.swift
//  ToDoSwiftUI
//
//  Created by Olesya Khurmuzakiy on 18.07.2023.
//

import SwiftUI

struct ContentView: View {
//    @State private var list = FileCache()
//    private var list = FileCache()
    var list = [TodoItem(text: "haha", importance: Importance.regular, created: Date()),
                TodoItem(text: "again haha", importance: Importance.unimportant, deadline: Date(), created: Date()), TodoItem(text: "not haha", importance: Importance.regular, created: Date()), TodoItem(text: "haha", importance: Importance.important, created: Date())]
    private var countDone = 0

    @State private var showDone = false
    @State private var isOn = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        Section {
                            ForEach(list) { item in
//                            ForEach(list.ListToDo) { item in
                                HStack {
                                    Toggle(isOn: $isOn) { }
                                    .toggleStyle(iOSCheckboxToggleStyle())

                                    VStack {
                                        Text("\(item.text)")
    //                                    Text("\(item.deadline)")
                                    }
                                }
//                                if item.done {
//
//                                        .strikethrough()
//                                        .foregroundColor(.gray)
//                                }
//                                Text("\(item.deadline)")
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button {
                                        print("Done")
                                    } label: {
                                        Label("Make done", systemImage: "checkmark.circle")
                                    }
                                    .tint(.green)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        print("Deleting item")
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                    Button() {
                                        print("Information")
                                    } label: {
                                        Label("Info", systemImage: "info.circle")
                                    }
                                }
                            }
                            
                            Button {
                                print("New add button tapped")
                            } label: {
                                Text("Новое")
                                    .foregroundColor(.gray)
                            }
                        }  header: {
                            HStack(alignment: .center, spacing: 0.0) {
                                Text("Выполнено - \(countDone)")
                                Spacer()
                                Button("Показать") {
                                    showDone.toggle()
                                }
                            }
//                            .padding(.horizontal, -20.0)
                        } footer: {
                                Text("©xwjkka")
                        }
                    }
                    .navigationTitle("Мои дела")
                }
                VStack {
                    Spacer()
                    Button {
                        print("Add button tapped")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            }
        })
    }
}
