//
//  ContentView.swift
//  ToDoSwiftUI
//
//  Created by Olesya Khurmuzakiy on 18.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var listApp = FileCache()
//    private var list = FileCache()
    @State private var list = [TodoItem(text: "haha", importance: Importance.regular, created: Date()),
                TodoItem(text: "again haha", importance: Importance.unimportant, deadline: Date(), created: Date()), TodoItem(text: "not haha", importance: Importance.regular, created: Date()), TodoItem(text: "haha", importance: Importance.important, created: Date())]
    @State var selectedItem: TodoItem? = nil
    
    private var countDone = 0

    @State private var showDone = false
    
    @State var isItemViewPresented = false

    var body: some View {
           NavigationView {
               ZStack {
                   List {
                       Section {
//                               ForEach(listApp.ListToDo) { item in
                           ForEach($list) { item in
//                               self.selectedItem = item
                               CellView(item: item)
                                   .frame(minHeight: 24)
                               .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                   Button {
                                       if let index = list.firstIndex(where: { $0.id == item.id }) {
                                           list[index].done.toggle()
                                       }

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
                                       self.isItemViewPresented = true
                                   } label: {
                                       Label("Info", systemImage: "info.circle")
                                   }
                                   .sheet(isPresented: $isItemViewPresented) {
//                                       ItemView(list: $list, item: item)
                                       ItemView(list: $list)
                                   }
                               }
                           }
                           
                           Button {
                               print("New add button tapped")
//                                   addAll()
                               self.isItemViewPresented = true
                           } label: {
                               Text("Новое")
                                   .foregroundColor(.gray)
                           }
                           .frame(height: 24)
                       } header: {
                           CustomHeader(showDone: $showDone, list: $list)
                       } footer: {
                               Text("©xwjkka")
                       }
                   }
                   .listStyle(.insetGrouped)
                   .navigationTitle("Мои дела")
                   
                   AddButtonView(isItemViewPresented: $isItemViewPresented, list: $list)
               }
           }
       }
    func addAll() {
        for item in list {
            listApp.addToDo(item)
        }
        print(listApp.ListToDo)
    }
}

struct AddButtonView: View {
    @Binding var isItemViewPresented: Bool
    @Binding var list: [TodoItem]
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                self.isItemViewPresented = true
                print("Add button tapped")
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                            .frame(width: 44, height: 44)

            }
            .sheet(isPresented: $isItemViewPresented) {
//                @var item = TodoItem(text: "", importance: .regular, created: Date())
                ItemView(list: $list)
            }
        }
    }
}

struct CustomHeader: View {
//    let countDone: Int
    @Binding var showDone: Bool
    @Binding var list: [TodoItem]
    
    func countDoneItems() -> Int {
        return list.filter { $0.done }.count
    }

    
    var body: some View {
        HStack {
            Text("Выполнено - \(countDoneItems())")
                .textCase(.none)
            Spacer()
            Button(action: {
                showDone.toggle()
            }) {
                if showDone {
                    Text("Скрыть")
                        .font(.system(size: 15))
                        .textCase(.none)
                } else {
                    Text("Показать")
                        .font(.system(size: 15))
                        .textCase(.none)
                }
            }
        }
        .padding(.horizontal, -16)
    }
}


struct CellView: View {
    @Binding var item: TodoItem
    
    var body: some View {
        
        HStack {
            Toggle(isOn: $item.done) { }
            .toggleStyle(customToggleStyle(importance: item.importance))


            VStack(alignment: .leading) {
                HStack {
                    if item.importance == .important {
                        Image(systemName: "exclamationmark.2")
                            .foregroundColor(.red)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.trailing, -5)
                    } else if item.importance == .unimportant {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.gray)
                            .padding(.trailing, -5)
                    }
                    if item.done {
                        Text(item.text)
                            .strikethrough(true, color: .gray)
                            .foregroundColor(.gray)
                    } else {
                        Text(item.text)
                    }
                }
                if let deadline = item.deadline {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                        Text(DateFormatter.DateFormatter.string(from: deadline))
                            .foregroundColor(.gray)
                            .padding(.leading, -5)
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

struct customToggleStyle: ToggleStyle {
    var importance: Importance
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            if configuration.isOn {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else if importance == .important {
                Image(systemName: "circle")
                    .foregroundColor(.red)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(.gray)
//                    .frame(width: 24, height: 24)
//                    .scaledToFit()
            }
        })
        
    }
}
