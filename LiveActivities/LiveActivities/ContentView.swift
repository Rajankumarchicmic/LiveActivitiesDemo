//
//  ContentView.swift
//  LiveActivities
//
//  Created by ChicMic on 10/08/23.
//

import SwiftUI
import ActivityKit
struct ContentView: View {
   @State var activity: Activity<NotificationAttributes>? = nil
     var song: [Song] = Song.getData()
    @State var change:  Bool = false
    @State var isPaused: Bool = true
    @State var slider = 45
    @State var index = 0
    @State var sliderValue : Float = 0.0
    var body: some View {

        VStack {
            Spacer()
            Image(song[index].songImage)
                .resizable()
                .frame(width: 350,height: 400)
                .cornerRadius(20)
            Spacer()
            Text(song[index].songName)
                .font(.system(size: 25,weight: .bold))
            Spacer()
            VStack{
                Slider(value: $sliderValue,
                           in: 0...1)
                .tint(.black)
                HStack(alignment: .center){
                    Spacer()
                    Text(song[index].Singername)
                        .font(.system(size: 18))
                    Spacer()
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25,height: 25)
                    Spacer()
                }
    
            }
            Spacer()
            HStack{
                Spacer()
                Button {
                    index = index <= 0  ?  0  : index - 1
                    update(data: song[index])
                    pushNotification()
                    change.toggle()
                } label: {
                    Image(systemName: "backward.end")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .shadow(color: .gray, radius: 20)
                }
                .tint(.black)
                
                
                Spacer()
                Button {
                    self.isPaused = !isPaused
                    if !self.isPaused {
                        startActivity(data: song[index])
                    }else{
                        stopActivity()
                    }
                } label: {
                    Image(systemName: isPaused ? "play.fill" : "pause.fill")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .shadow(color: .gray, radius: 20)
                }
                .tint(.black)
                Spacer()
                Button {
                    index = index >= song.count - 1 ?  song.count - 1 : index + 1
                    update(data: song[index])
                    pushNotification()
                    change.toggle()
                } label: {
                    Image(systemName: "forward.end")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .shadow(color: .gray, radius: 20)
                }
                .tint(.black)
                Spacer()
            }
           Spacer()
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }
            }
        })
                .padding()
                .background(LinearGradient(colors: [.gray.opacity(0.5),.gray.opacity(0.2)], startPoint: .bottomTrailing, endPoint: .topLeading))
                .cornerRadius(20)
                .shadow(radius: 10)
                .ignoresSafeArea()
            }
      
   
    func startActivity(data: Song){
        let attribute = NotificationAttributes(name: "Rajan")
        let state = NotificationAttributes.notificationValue(songName: data.songName, songImage: data.songImage, singerName: data.Singername, isPlay: isPaused, value: data.value)
        
        activity =  try? Activity<NotificationAttributes>.request(attributes: attribute, contentState: state)
    }
    
    func stopActivity(){
        Task {
            for activity in Activity<NotificationAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
            }
        }
        
    }
    
    func update(data: Song){
        Task{
            let state = NotificationAttributes.notificationValue(songName: data.songName, songImage: data.songImage, singerName: data.Singername, isPlay: isPaused, value: data.value)
            let alertConfiguration = AlertConfiguration(title: "Song update", body: "\(data.songName)", sound: .default)
          
            await activity?.update(using:state,alertConfiguration: alertConfiguration)
   
        }
  
        
    }
    
    func pushNotification(){
        let content = UNMutableNotificationContent()
           content.title = "Live Activity Update"
           content.body = "A new live activity is available!"
           content.sound = UNNotificationSound.default

           // Create a trigger for the notification (for example, trigger after 5 seconds)
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

           // Create a notification request
           let request = UNNotificationRequest(identifier: "liveActivityUpdate", content: content, trigger: trigger)

           // Schedule the notification
           UNUserNotificationCenter.current().add(request) { (error) in
               if let error = error {
                   print("Error scheduling notification: \(error.localizedDescription)")
               } else {
                   print("Notification scheduled successfully")
               }
           }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Song{
    var songName: String
    var songImage: String
    var Singername: String
    var value: Int
    
    static func getData()-> [Song]{
        let songArray = [Song(songName: "How Far", songImage: "song", Singername: "Saimie Bower,laddy gaga, katty perry", value: 1), Song(songName: "Unstopable", songImage: "song1", Singername: "Sia", value: 1)]
        return songArray
    }
}
