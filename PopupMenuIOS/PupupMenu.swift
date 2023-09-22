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
    @State private var isShowingWithAnimation = false
    
    init (isShowing: Binding<Bool>, @ViewBuilder listBuilder: () -> T) {
        self._isShowing = isShowing
        self.list = listBuilder()
    }
    
    var body: some View {
        ZStack {
            if isShowingWithAnimation {
                Rectangle().fill(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial.opacity(0.7), in: Rectangle())
                    .onTapGesture {
                        isShowing = false
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
                                if value.translation.height > 12 {
                                    let height = reader.size.height * 0.4
                                    if scrollHeight == height {
                                        isShowing = false
                                    } else {
                                        withAnimation(.spring()) {
                                            scrollHeight = height
                                        }
                                    }
                                } else if value.translation.height < 0 {
                                    withAnimation(.spring()) {
                                        scrollHeight = reader.size.height
                                    }
                                }
                            }))
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.scale)
                .zIndex(1)
            }
        }
        .onChange(of: isShowing) { newValue in
            withAnimation(.spring()) {
                isShowingWithAnimation = newValue
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
