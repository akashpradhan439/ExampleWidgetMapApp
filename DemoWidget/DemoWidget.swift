//
//  CoolWidget.swift
//  CoolWidget
//
//  Created by MMI on 21/12/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

       let currentDate = Date()
       for hourOffset in 0 ..< 5 {
           if let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate) {
               let entry = SimpleEntry(date: entryDate, configuration: configuration)
               entries.append(entry)
           } else {
               let errorEntry = SimpleEntry(date: currentDate,
                                            configuration: configuration)
               entries.append(errorEntry)
           }
       }

       let timeline = Timeline(entries: entries,
                               policy: .atEnd)
       completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct CoolWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    @State var image: Image? = nil
       
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            ZStack {

                if image != nil {
                    image!
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                }
          
                Link(destination: URL(string: "widget-deeplink://search")!, label: {
                
                    Image("icons8-search-100")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(.thinMaterial)
                        .cornerRadius(15)
                        .padding(20)
                        .onAppear {
                            let sharedContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.Mappls.MapplsSDKDemo.DemoWidget")
                            let fileURL = sharedContainer?.appendingPathComponent("widgetImage.png")
                            if fileURL == nil {
                                return
                            }
                            if let imageData = try? Data(contentsOf: fileURL!), let image = UIImage(data: imageData) {
                                self.image = Image(uiImage: image)
                            }
                        }
                })
            }
        default:
            ZStack {

                if image != nil {
                    if widgetFamily == .systemMedium {
                        GeometryReader {geo in
                            image!
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipShape(Rectangle())
                                .opacity(0.8)
                        }

                    }else{
                        image!
                            .resizable()
                            .scaledToFill()
                            .opacity(0.8)
                    }
                }
                VStack{
                    Link(destination: URL(string: "widget-deeplink://search")!, label: {
                        HStack {
                            Image("icons8-search-100")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(10)
                                .background(.clear)
                            
                            Text("Search...")
                                .foregroundColor(.gray)
                                .background(.clear)
                                .font(.caption)
                                .frame(width: 80, height: 40)
                            
                            Spacer()
                        }
                        .background(.white.opacity(0.9))
                        .cornerRadius(15)
                        .padding(10)
                    })
                    if widgetFamily == .systemMedium {
                        Spacer()
                    }
                    
                    HStack {
                        
                        Spacer()
                        
                        Link(destination: URL(string: "widget-deeplink://restaurants")!, label: {
                        
                          IconImage(iconName: "fork.knife", systemNamed: true)
                        
                        })
                        Spacer()
                        
                        Link(destination: URL(string: "widget-deeplink://pubsandbars")!, label: {
                
                            IconImage(iconName: "cocktail", systemNamed: false)
                        })
                        
                        Spacer()
                        
                        Link(destination: URL(string: "widget-deeplink://coffee")!, label: {

                           IconImage(iconName: "cup.and.saucer.fill", systemNamed: true)

                        })
                        Spacer()
                    }
                    .padding([.top, .bottom], 10)
                    .background(.white.opacity(0.3))
                    
                    if widgetFamily == .systemLarge {

                        HStack {
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://parking")!, label: {
                            
                               IconImage(iconName: "parkingsign", systemNamed: true)
                            
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://atm")!, label: {
                    
                                IconImage(iconName: "atm", systemNamed: false)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://pharmacy")!, label: {
                    
                                IconImage(iconName: "drug", systemNamed: false)
                            
                            })
                            
                            Spacer()
                        }
                        .padding([.top, .bottom], 10)
                        .background(.white.opacity(0.3))
                        
                        HStack {
                            Spacer()

                            Link(destination: URL(string: "widget-deeplink://transport")!, label: {
                            
                               IconImage(iconName: "bus", systemNamed: true)
                            
                            })
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://hospitals")!, label: {
                    
                                IconImage(iconName: "hospital", systemNamed: false)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://hotels")!, label: {
                    
                                IconImage(iconName: "hotel", systemNamed: false)
                            
                            })
                            Spacer()
                        }
                        .padding([.top, .bottom], 10)
                        .background(.white.opacity(0.3))
                    }
                }
            }
            .onAppear {
                let sharedContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.Mappls.MapplsSDKDemo.DemoWidget")
                let fileURL = sharedContainer?.appendingPathComponent("widgetImage.png")
                if fileURL == nil {
                    return
                }
                if let imageData = try? Data(contentsOf: fileURL!), let image = UIImage(data: imageData) {
                    self.image = Image(uiImage: image)
                }
            }
        }
    }
}

@main
struct DemoWidget: Widget {
    let kind: String = "CoolWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CoolWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemSmall, .systemLarge])
    }
}

struct IconImage: View {
    
    var iconName: String
    var systemNamed: Bool
    
    var body: some View {
        if systemNamed {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(10)
                .background(.thinMaterial)
                .cornerRadius(15)
                .padding([.leading, .trailing], 20)
        }else {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(10)
                .background(.thinMaterial)
                .cornerRadius(15)
                .padding([.leading, .trailing], 20)
        }
            
    }
}
