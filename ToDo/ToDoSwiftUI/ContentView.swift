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

                                       VStack {
                                           Text("\(item.text)")
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
                           NavigationViewWithButtons()
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
    @State private var isSaveButtonPressed = false
    @State private var isCancelButtonPressed = false
    
    @State private var isDeadlineOn = false
    @State private var isCalendarVisible = false
    
//    private var todoText = ""
    @State private var selectedImportance = 1

    @State var todoText: String = ""
    @State var deadlineDate: Date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Что делать?", text: $todoText)
                        .frame(minHeight: 120)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    VStack {
                        HStack {
                            Text("Важность")
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    selectedImportance = 0
                                }) {
                                    Image(systemName: "arrow.down")
                                    //                                    .foregroundColor(.gray)
                                        .foregroundColor(selectedImportance == 2 ? .gray : .red)
                                }
                                .padding(2)
                                
                                Button(action: {
                                    selectedImportance = 1
                                }) {
                                    Text("нет")
                                        .foregroundColor(selectedImportance == 1 ? .black : .black)
                                }
                                .padding(2)
                                
                                Button(action: {
                                    selectedImportance = 2
                                }) {
                                    Image(systemName: "exclamationmark.2")
                                    //                                    .foregroundColor(.red)
                                        .foregroundColor(selectedImportance == 2 ? .red : .gray)
                                }
                                .padding(2)
                            }
                            .shadow(color: .blue, radius: 10)
                        } .padding([.top, .leading, .trailing])
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
                    .background(Color.white)
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
                    .frame(maxWidth: .infinity) // Задаем кнопке ширину во весь экран
                    .background(Color.gray)
                    .cornerRadius(10)
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
                        self.isSaveButtonPressed = true
                    }) {
                        Text("Сохранить")
                    }
                )
            }
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
