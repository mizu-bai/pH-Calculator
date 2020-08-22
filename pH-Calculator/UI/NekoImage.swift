//
//  NekoImage.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/22.
//

import SwiftUI

struct NekoImage: View {
    
    var body: some View {
        
        Image("Neko")
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30).stroke(Color.gray, lineWidth: 4)
            )
            .shadow(radius: 10)
        
    }
}

struct NekoImage_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NekoImage()
        
    }
}
