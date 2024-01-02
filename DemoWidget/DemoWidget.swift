

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

                        Link(destination: URL(string: "widget-deeplink://0")!, label: {

                            IconImage(iconName: SharedWidgetClass
                                .shared.buttons[0].buttonIcon)
                        })
                        
                        Spacer()
                        
                        Link(destination: URL(string: "widget-deeplink://1")!, label: {
                            
                            IconImage(iconName: SharedWidgetClass.shared.buttons[1].buttonIcon)
                        })
                        
                        Spacer()
                        
                        Link(destination: URL(string: "widget-deeplink://2")!, label: {
                            
                            IconImage(iconName: SharedWidgetClass.shared.buttons[2].buttonIcon)
                            
                        })
                        Spacer()
                    }
                    .padding([.top, .bottom], 10)
                    .background(.white.opacity(0.3))
                    
                    if widgetFamily == .systemLarge {
                        
                        HStack {
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://3")!, label: {
                                
                                IconImage(iconName: SharedWidgetClass.shared.buttons[3].buttonIcon)
                                
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://4")!, label: {
                                
                                IconImage(iconName: SharedWidgetClass.shared.buttons[4].buttonIcon)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://5")!, label: {
                                
                                IconImage(iconName: SharedWidgetClass.shared.buttons[5].buttonIcon)
                                
                            })
                            
                            Spacer()
                        }
                        .padding([.top, .bottom], 10)
                        .background(.white.opacity(0.3))
                        
                        HStack {
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://6")!, label: {
                                
                                IconImage(iconName: SharedWidgetClass.shared.buttons[6].buttonIcon)
                                
                            })
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://7")!, label: {
                                
                                IconImage(iconName: SharedWidgetClass.shared.buttons[7].buttonIcon)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://8")!, label: {
                                
                                IconImage(iconName: SharedWidgetClass.shared.buttons[8].buttonIcon)
                                
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
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .padding(10)
            .background(.thinMaterial)
            .cornerRadius(15)
            .padding([.leading, .trailing], 20)
    }
}

