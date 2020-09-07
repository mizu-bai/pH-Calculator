//
//  ContentView.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/6/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            
            NekoImage()
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("pH Calculator")
                    .font(.title)
                
                HStack {
                    
                    Text("by mizu-bai")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                Spacer()
                    
                }
                
                Text("差不多就差 UI 了，有缘再写，咕咕咕。")
                    
            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
        
    }
}
