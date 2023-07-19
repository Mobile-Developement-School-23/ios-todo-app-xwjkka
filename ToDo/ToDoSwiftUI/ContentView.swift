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
    @State private var list = [TodoItem(text: "haha", importance: Importance.regular, created: Date()),
                TodoItem(text: "again haha", importance: Importance.unimportant, deadline: Date(), created: Date()), TodoItem(text: "not haha", importance: Importance.regular, created: Date()), TodoItem(text: "haha", importance: Importance.important, created: Date())]
    private var countDone = 0

    @State private var showDone = false
    @State private var isOn = false
    
    @State var isNavigationViewPresented = false

    
    var body: some View {
           NavigationView {
               ZStack {
                   VStack {
                       List {
                           Section {
                               ForEach(list) { item in
                                   HStack {
                                       Toggle(isOn: $isOn) { }
                                       .toggleStyle(iOSCheckboxToggleStyle())

                                       VStack(alignment: .leading) {
                                           Text("\(item.text)")
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
                                   self.isNavigationViewPresented = true
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
//                                   .font(15)
                               }
                           } footer: {
                                   Text("©xwjkka")
                           }
                       }
                       .navigationTitle("Мои дела")
                   }
                   VStack {
                       Spacer()
                       Button {
                           self.isNavigationViewPresented = true
                           print("Add button tapped")
                       } label: {
                           Image(systemName: "plus.circle.fill")
                               .resizable()
                                       .frame(width: 44, height: 44)

                       }
                       .sheet(isPresented: $isNavigationViewPresented) {
                           NavigationViewWithButtons(list: $list)
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

struct NavigationViewWithButtons: View {
    @Binding var list: [TodoItem]
//    @Binding var id: Int?
    
    @State private var isSaveButtonPressed = false
    @State private var isCancelButtonPressed = false
    
    @State private var isDeadlineOn = false
    @State private var isCalendarVisible = false
    
    @State private var selectedImportance = 1

    @State var todoText: String = ""
    @State var deadlineDate: Date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Что делать?", text: $todoText)
//                        .frame(minHeight: 120)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    VStack {
                        ImportanceView(selectedImportance: $selectedImportance)
                        DeadlineView(isDeadlineOn: $isDeadlineOn, isCalendarVisible: $isCalendarVisible, deadlineDate: $deadlineDate)
                    } .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.vertical)
                    
                    Button(action: {
                        self.isCancelButtonPressed = true
                    }) {
                        Text("Удалить")
                            .foregroundColor(.red)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    Spacer()
                }
                .padding()
                
                .navigationBarTitle("Дело")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(leading:
                                        Button("Отменить") {
                    presentationMode.wrappedValue.dismiss()
                }
                )
                .navigationBarItems(trailing:
                    Button(action: {
                    var deadlineForItem: Date?
                    if isDeadlineOn {
                        deadlineForItem = deadlineDate
                    }
                    var importance = Importance.regular
                    if selectedImportance == 0 {
                        importance = .unimportant
                    } else if selectedImportance == 2 {
                        importance = .important
                    }
                    let item = TodoItem(text: todoText, importance: importance, deadline: deadlineForItem, done: false, created: Date())
                    list.append(item)
                    presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Сохранить")
                    } .disabled(todoText.isEmpty)
                )
            }
        }
    }
}

struct ImportanceView: View {
    @Binding var selectedImportance: Int
    var body: some View {
        VStack {
            HStack {
                Text("Важность")
                Spacer()
                Picker(selection: $selectedImportance, label: Text("")) {
                        Image(systemName: "arrow.down").tag(0)
                        Text("нет").tag(1)
                        Image(systemName: "exclamationmark.2")
                            .foregroundColor(.red)
                            .tag(2)
                    }
                    .frame(maxWidth: 150)
                    .pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding([.top, .leading, .trailing])
        }
    }
}

struct DeadlineView: View {
    @Binding var isDeadlineOn: Bool
    @Binding var isCalendarVisible: Bool
    @Binding var deadlineDate: Date
    
    var body: some View {
        Toggle(isOn: $isDeadlineOn) {
            Text("Сделать до")
            if isDeadlineOn {
                Button(action: {
                    isCalendarVisible.toggle()
                }) {
                    Text(DateFormatter.DateFormatter.string(from: deadlineDate))
                }
            }
        } .padding([.bottom, .leading, .trailing])
        
        if isCalendarVisible {
            DatePicker(
                selection: $deadlineDate,
                displayedComponents: [.date],
                label: {}
            )
            .padding(.top, -20)
            .padding([.leading, .trailing])
            .datePickerStyle(GraphicalDatePickerStyle())
        }
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
