//
//  NotificationLiveActivity.swift
//  Notification
//
//  Created by ChicMic on 10/08/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct NotificationAttributes: ActivityAttributes {
    public typealias notificationValue = ContentState
    public struct ContentState: Codable, Hashable {
        var songName: String
        var songImage: String
        var singerName: String
        var isPlay: Bool
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }
    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct NotificationLiveActivity: Widget {
    @State var value: Float = 0.5
    @State var isPlay = false
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NotificationAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Spacer()
                HStack{
                    Spacer()
                        .frame(width: 5)
                    Image(context.state.songImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .cornerRadius(5)
                    Spacer()
                    Text("\(context.state.songName)")
                    Spacer()
                }
                Spacer()
                VStack{
                
                    HStack(alignment: .center){
                        Spacer()
                        Text(context.state.singerName)
                            .font(.system(size: 18))
                            .animation(Animation.linear.repeatForever())
                        Spacer()
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 25,height: 25)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Button {
                
                        } label: {
                            Image(systemName: "backward.end")
                                .resizable()
                                .frame(width: 15,height: 15)
                                .foregroundColor(Color.black)
                                .shadow(color: .gray, radius: 20)
                        }
                        .tint(.black)
                        
                        
                        Spacer()
                        Button {
                            self.isPlay = !self.isPlay
                        } label: {
                            Image(systemName: !self.isPlay ? "pause.fill" : "play.fill")
                                .resizable()
                                .frame(width: 20,height: 20)
                                .foregroundColor(Color.black)
                                .shadow(color: .gray, radius: 20)
                        }
                        .tint(.black)
                        Spacer()
                        Button {
                            print("Forward>>>>>>>>>>>>>>>>>>>")
                        } label: {
                            Image(systemName: "forward.end")
                                .resizable()
                                .frame(width: 15,height: 15)
                                .foregroundColor(Color.black)
                                .shadow(color: .gray, radius: 20)
                        }
                        .tint(.black)
                        Spacer()
                    }
                }
                Spacer()
            }
            .activityBackgroundTint(Color.white)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack{
                        Image(context.state.songImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .cornerRadius(5)
                        Text("\(context.state.songName)")
                    }

                }
                DynamicIslandExpandedRegion(.trailing) {
                    Image(systemName: "waveform")
                        .foregroundColor(.gray)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack{
                    
                        HStack(alignment: .center){
                            Spacer()
                            Text(context.state.singerName)
                                .font(.system(size: 18))
                                .animation(Animation.linear.repeatForever())
                            Spacer()
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 25,height: 25)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Button {
                            } label: {
                                Image(systemName: "backward.end")
                                    .resizable()
                                    .frame(width: 15,height: 15)
                                    .foregroundColor(Color.white)
                                    .shadow(color: .gray, radius: 20)
                            }
                            .tint(.black)
                            
                            
                            Spacer()
                            Button {
                            } label: {
                                Image(systemName: "pause.fill")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                    .foregroundColor(Color.white)
                                    .shadow(color: .gray, radius: 20)
                            }
                            .tint(.black)
                            Spacer()
                            Button {
                                print("Forward>>>>>>>>>>>>>>>>>>>")
                            } label: {
                                Image(systemName: "forward.end")
                                    .resizable()
                                    .frame(width: 15,height: 15)
                                    .foregroundColor(Color.white)
                                    .shadow(color: .gray, radius: 20)
                            }
                            .tint(.black)
                            Spacer()
                        }
                    }
                    // more content
                }
            } compactLeading: {
                    Image(systemName: "waveform")
                        .foregroundColor(.pink)
            } compactTrailing: {
                Text(context.state.songName)
            } minimal: {
               
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//struct NotificationLiveActivity_Previews: PreviewProvider {
//    static let attributes = NotificationAttributes(name: "Me")
//    static let contentState = NotificationAttributes.ContentState(value: 3)
//
//    static var previews: some View {
//        if #available(iOSApplicationExtension 16.2, *) {
//            attributes
//                .previewContext(contentState, viewKind: .dynamicIsland(.compact))
//                .previewDisplayName("Island Compact")
//        } else {
//            // Fallback on earlier versions
//        }
//        attributes
//            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
//            .previewDisplayName("Island Expanded")
//        attributes
//            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
//            .previewDisplayName("Minimal")
//        attributes
//            .previewContext(contentState, viewKind: .content)
//            .previewDisplayName("Notification")
//    }
//}
