//
//  PupupMenu.swift
//  PopupMenuIOS
//
//  Created by Shahrukh on 21/09/2023.
//

import SwiftUI

struct PupupMenu<T: View>: View {
    @Binding private var isShowing: Bool
    var list: T
    
    @State private var scrollHeight: CGFloat = UIScreen.main.bounds.height * 0.4
    
    init (isShowing: Binding<Bool>, @ViewBuilder listBuilder: () -> T) {
        self._isShowing = isShowing
        self.list = listBuilder()
    }
    
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle().fill(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial.opacity(0.7), in: Rectangle())
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
                
                GeometryReader { reader in
                    VStack {
                        Spacer()
                        ScrollView(showsIndicators: false) {
                            list
                        }
                        .frame(height: scrollHeight)
                        .simultaneousGesture(
                            DragGesture().onChanged({ value in
                                print(value.translation.height)
                                withAnimation {
                                    if value.translation.height > 12 {
                                        let height = reader.size.height * 0.4
                                        if scrollHeight == height {
                                            isShowing = false
                                        } else {
                                            scrollHeight = height
                                        }
                                    } else if value.translation.height < 0 {
                                        scrollHeight = reader.size.height
                                    }
                                }
                            }))
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                .zIndex(1)
            }
        }
    }
}

struct PupupMenu_Previews: PreviewProvider {
    static var previews: some View {
        PupupMenu(isShowing: .constant(true)) {
            
        }
    }
}
