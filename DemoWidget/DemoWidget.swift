

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entry = SimpleEntry(date: .now)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct CoolWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily

    @State var image: Image? = nil
    
    @State var button1: String = "house"
    @State var button2: String = "cross.case.fill"
    @State var button3: String = "cup.and.saucer.fill"
    @State var button4: String = "building"
    @State var button5: String = "pills.fill"
    @State var button6: String = "bus"
    @State var button7: String = "parkingsign"
    @State var button8: String = "cocktail"
    @State var button9: String = "fork.knife"
    @State var button10: String = "banknote.fill"

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            ZStack {
                
                if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
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

                    VStack {
                        HStack {

                            Spacer()

                            Link(destination: URL(string: "widget-deeplink://0")!, label: {

                                IconImage(iconName: button1)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://1")!, label: {

                                IconImage(iconName: button2)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://2")!, label: {
                                
                                IconImage(iconName: button3)
                            })
                            Spacer()
                        }
                        
                        if widgetFamily == .systemLarge {
                            
                            HStack {
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://3")!, label: {
                                    
                                    IconImage(iconName: button4)
                                })
                                
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://4")!, label: {

                                    IconImage(iconName: button5)
                                })
                                
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://5")!, label: {

                                    IconImage(iconName: button6)
                                })
                                
                                Spacer()
                            }

                            
                            HStack {
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://6")!, label: {
                                    
                                    IconImage(iconName: button7)
                                })
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://7")!, label: {

                                    IconImage(iconName: button8)
                                })
                                
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://8")!, label: {
                                    
                                    IconImage(iconName: button9)
                                })
                                Spacer()
                            }
                        }
                    }
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding(widgetFamily == .systemMedium ? 10 : 20)
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
                
                if let iconName = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button1") {
                    button1 = iconName
                }else {
                    return
                }
                button2 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button2")!
                button3 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button3")!
                button4 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button4")!
                button5 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button5")!
                button6 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button6")!
                button7 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button7")!
                button8 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button8")!
                button9 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button9")!
                button10 = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.string(forKey: "button10")!
            }
        }
    }
}

@main
struct DemoWidget: Widget {
    let kind: String = "CoolWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), content: { entry in
            CoolWidgetEntryView(entry: entry)
        })
        .configurationDisplayName("Mappls Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemSmall, .systemLarge])
    }
}

