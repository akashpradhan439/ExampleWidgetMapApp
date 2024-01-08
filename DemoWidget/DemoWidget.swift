

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    @AppStorage("MapplsWidget", store: UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")) var primaryData : Data = Data()

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        guard let buttonsData = try? JSONDecoder().decode(ButtonsData.self, from: primaryData) else {
            return
        }
        let entry = SimpleEntry(date: Date(), buttonsData: buttonsData)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        guard let buttonsData = try? JSONDecoder().decode(ButtonsData.self, from: primaryData) else {
            return
        }
        
        let entry = SimpleEntry(date: Date(), buttonsData: buttonsData)
        
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), buttonsData: ButtonsData())
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let buttonsData: ButtonsData
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

                            Link(destination: URL(string: "widget-deeplink://1")!, label: {

                                IconImage(iconName: entry.buttonsData.but1.values.first!)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://2")!, label: {

                                IconImage(iconName: entry.buttonsData.but2.values.first!)
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: "widget-deeplink://3")!, label: {
                                
                                IconImage(iconName: entry.buttonsData.but3.values.first!)
                            })
                            Spacer()
                        }
                        
                        if widgetFamily == .systemLarge {
                            
                            HStack {
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://4")!, label: {
                                    
                                    IconImage(iconName: entry.buttonsData.but4.values.first!)
                                })
                                
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://5")!, label: {

                                    IconImage(iconName: entry.buttonsData.but5.values.first!)
                                })
                                
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://6")!, label: {

                                    IconImage(iconName: entry.buttonsData.but6.values.first!)
                                })
                                
                                Spacer()
                            }

                            
                            HStack {
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://7")!, label: {
                                    
                                    IconImage(iconName: entry.buttonsData.but7.values.first!)
                                })
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://8")!, label: {

                                    IconImage(iconName: entry.buttonsData.but8.values.first!)
                                })
                                
                                Spacer()
                                
                                Link(destination: URL(string: "widget-deeplink://9")!, label: {
                                    
                                    IconImage(iconName: entry.buttonsData.but9.values.first!)
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
                print(entry.buttonsData.but1.values.first!)
                if let imageData = try? Data(contentsOf: fileURL!), let image = UIImage(data: imageData) {
                    self.image = Image(uiImage: image)
                }
            }
        }
    }
}

@main
struct DemoWidget: Widget {
    let kind: String = "MapplsWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), content: { entry in
            CoolWidgetEntryView(entry: entry)
        })
        .configurationDisplayName("Mappls Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemSmall, .systemLarge])
    }
}

