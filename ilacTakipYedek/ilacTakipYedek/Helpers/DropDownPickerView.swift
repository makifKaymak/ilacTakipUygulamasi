//
//  DropDownPickerView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 24.03.2024.
//

import SwiftUI

struct DropDownPickerView: View {
    //Customization Properties
    var hint: String
    var options: [String]
    var anchor: Anchor = .bottom
    var maxWidth: CGFloat = 180
    var cornerRadius: CGFloat = 15
    @Binding var selection: String?
    @State private var showOptions = false
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? .gray : .primary)
                        .lineLimit(1)
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        showOptions.toggle()
                    }
                }
                .background((scheme == .dark ? Color.black : Color.white).shadow(.drop(color: .primary.opacity(0.15), radius: 4)), in: .rect(cornerRadius: cornerRadius))
            }
        }
        .frame(width: maxWidth, height: 50)
    }
    
    //DropDown Direction
    
    enum Anchor {
        case top
        case bottom
    }
}


