//
//  ContentView.swift
//  FreezingApp
//
//  Created by KAWASHIMA Yoshiyuki on 2022/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var blocking = false
    @State private var processing = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $blocking) {
                Text("Blocking")
            }
            Divider()
            
            Spacer()
            
            if self.processing {
                ProgressView()
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            
            Text("Hello, world!")
            
            Spacer()

            Button("Push Me!", action: self.blocking ? doWithBlocking : doWithNonBlocking)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
        .padding()
    }
    
    func doWithNonBlocking() {
        print("nonBlocking -- start")
        
        processing = true
        
        DispatchQueue.global().async {
            sleep(3)
            
            DispatchQueue.main.async {
                processing = false
        
                print("nonBlocking -- end")
            }
        }
    }
    
    func doWithBlocking() {
        print("blocking -- start")
        
        processing = true
        
        // ここでスレッドをブロックするため、描画更新スレッドが動かないので、
        // 画面の更新が行われません
        sleep(3)
        
        // スレッドブロックが解除され、描画更新スレッドが動く時には、
        // 処理中のフラグが下がるのでインジケーターは表示されません
        processing = false
        
        print("blocking -- end")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
