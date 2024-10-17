//
//  ContentView.swift
//  CustomMenu
//
//  Created by Arjunan on 30/07/24.
//

import SwiftUI

struct MenuView<Content: View>: View {
    @Binding var isPopoverPresented: Bool
    @Binding var selectedOption: String
    let options: [String]
    let content: Content
    
    init(isPopoverPresented: Binding<Bool>, selectedOption: Binding<String>, options: [String], @ViewBuilder content: () -> Content) {
        self._isPopoverPresented = isPopoverPresented
        self._selectedOption = selectedOption
        self.options = options
        self.content = content()
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPopoverPresented.toggle()
                }) {
                    HStack {
                        Text(selectedOption)
                            .foregroundColor(.black)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1))
                }
                .popover(isPresented: $isPopoverPresented, arrowEdge: .leading) {
                    VStack {
                        ForEach(options, id: \.self) { option in
                            Button(option) {
                                selectedOption = option
                                isPopoverPresented = false
                            }
                            .padding()
                        }
                    }
                    .frame(width: 200) // Adjust width as needed
                }
                Spacer()
            }
            .padding()
        }
        .background(Color.clear)
    }
}

struct ContentView: View {
    @State private var isPopoverPresented = false
    @State private var selectedOption: String = "Select an Option"
    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        MenuView(isPopoverPresented: $isPopoverPresented, selectedOption: $selectedOption, options: options) {
            Text("Menu")
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomMenu: View {
    @State private var isMenuOpen: Bool = false
    @State private var selectedLevel: String = "Select Level" 

    var body: some View {
        ZStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                HStack {
                    Text(selectedLevel)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 11, height: 7)
                        .foregroundColor(.black)
                }
                .padding(8)
                .frame(width: 150)
                .background(Color.white)
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            }

//            if isMenuOpen {
//                menuFilterView
//                    .offset(x: 0, y: 40) // Adjust vertical offset as needed
//                    .zIndex(1) // Ensure it appears on top of other views
//            }
        }
    }
}
