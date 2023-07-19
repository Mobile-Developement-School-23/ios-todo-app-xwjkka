//
//  ItemView.swift
//  ToDoSwiftUI
//
//  Created by Olesya Khurmuzakiy on 19.07.2023.
//

import SwiftUI

struct ItemView: View {
    @Binding var list: [TodoItem]
    
    @State private var isSaveButtonPressed = false
    @State private var isCancelButtonPressed = false
    
    @State private var isDeadlineOn = false
    @State private var isCalendarVisible = false
    
    @State private var selectedImportance = 1

    @State var todoText: String = ""
    @State var deadlineDate: Date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    TextField("Что делать?", text: $todoText)
                        .frame(minHeight: 120)
                        .lineLimit(nil)

                    Section {
                        ImportanceView(selectedImportance: $selectedImportance)
                        DeadlineView(isDeadlineOn: $isDeadlineOn, isCalendarVisible: $isCalendarVisible, deadlineDate: $deadlineDate)
                    }
                    Section {
                        Button(action: {
                            self.isCancelButtonPressed = true
                        }) {
                            Text("Удалить")
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                                .padding(.vertical, 10)

                        }
                    }
                    
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
                            .font(.system(size: 20, weight: .bold))
                            .tag(2)
                    }
                    .frame(maxWidth: 150)
                    .pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(4)
        }
    }
}

struct DeadlineView: View {
    @Binding var isDeadlineOn: Bool
    @Binding var isCalendarVisible: Bool
    @Binding var deadlineDate: Date
    
    var body: some View {
//        withAnimation{
            Toggle(isOn: $isDeadlineOn) {
                Text("Сделать до")
                if isDeadlineOn {
                    Button(action: {
                        withAnimation {
                            isCalendarVisible.toggle()
                        }
                    }) {
                        Text(DateFormatter.DateFormatter.string(from: deadlineDate))
                    }
                }
            }
            .padding(4)
//        }
        
        if isCalendarVisible {
            DatePicker(
                selection: $deadlineDate,
                displayedComponents: [.date],
                label: {}
            )
            .padding(.top, -20)
            .datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}
