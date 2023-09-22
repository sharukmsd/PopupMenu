//
//  ContentView.swift
//  PopupMenuIOS
//
//  Created by Shahrukh on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isShown = false
    @State var options = [ "New Chat", "New Group", "Contacts", "Recent Chats", "Archived Chats", "Starred Messages","Settings","Profile","Notifications","Privacy","Themes","Chat Backup","Media Gallery","Search","Help & Support","Invite Friends","Rate the App","Logout","Delete Account","About"]
    
    var body: some View {
        ZStack {
            Button {
                isShown = true
            } label: {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(.gray.opacity(0.1))
                    )
            }
            .padding()
            
            PupupMenu(isShowing: $isShown) {
                ForEach(options, id: \.self) { option in
                    HStack {
                        Text(option)
                        Spacer()
                    }
                    .padding()
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
