//
//  ButtonStyle.swift
//  ParOn_Yubin
//
//  Created by Yubin on 2023/05/12.
//

import Foundation
import SwiftUI

struct BigButtonStyle: ButtonStyle {

    @State var color: Color = .indigo

    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .font(.title.bold())
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(12)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                        .cornerRadius(12)
                }
            }
    }
}

extension ButtonStyle where Self == BigButtonStyle {
    static var bigbuttonStyle: Self { Self() }
}
