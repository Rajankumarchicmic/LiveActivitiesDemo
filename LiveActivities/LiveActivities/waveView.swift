//
//  waveView.swift
//  LiveActivities
//
//  Created by ChicMic on 11/08/23.
//

import SwiftUI

struct waveView: View {
    
    @ViewBuilder func rectangle(height: CGFloat)-> some View{
        Rectangle()
            .frame(width: 5, height: height)
    }
    var body: some View {
        HStack(spacing: 5){
            rectangle(height: 15)
                .animation(Animation.easeInOut.repeatForever(), value: true)
            rectangle(height: 25)
            rectangle(height: 35)
            rectangle(height: 25)
            rectangle(height: 15)
        }

    }
}

struct waveView_Previews: PreviewProvider {
    static var previews: some View {
        waveView()
    }
}
