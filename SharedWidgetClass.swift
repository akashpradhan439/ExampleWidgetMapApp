import Foundation
import SwiftUI
import WidgetKit
import Intents
import UIKit

class SharedWidgetClass {
    static let shared = SharedWidgetClass()
    
    @AppStorage("MapplsWidget", store: UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")) var primaryData : Data = Data()
    
    let buttonsData: ButtonsData
    
    private init(){
        buttonsData = ButtonsData()
    }
    
    func encodeData(){
        guard let data = try? JSONEncoder().encode(buttonsData) else {
            return
        }
        
        primaryData = data
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadTimelines(ofKind: "MapplsWidget")
        }
    }
    
    func changeWidget(buttonsData: ButtonsData){
        guard let data = try? JSONEncoder().encode(buttonsData) else {
            return
        }
        primaryData = data
        if #available(iOS 14.0, *){
            WidgetCenter.shared.reloadTimelines(ofKind: "MapplsWidget")
        }
    }
}

struct ButtonsData: Codable {
    var but1 : [String: String] = ["hospital": "cross.case.fill"]
    var but2 : [String: String] = ["coffee": "cup.and.saucer.fill"]
    var but3 : [String: String] = ["hotel": "building"]
    var but4 : [String: String] = ["bus": "bus"]
    var but5 : [String: String] = ["medicine": "pills.fill"]
    var but6 : [String: String] = ["atm": "banknote.fill"]
    var but7 : [String: String] = ["parking": "parkingsign"]
    var but8 : [String: String] = ["bar": "cocktail"]
    var but9 : [String: String] = ["restaurant": "fork.knife"]
    var but10 : [String: String] = ["home": "house"]
}

struct IconImage: View {
    
    var iconName: String
    
    var body: some View {
        if #available(iOS 15.0, *) {
            if let _ = UIImage(systemName: iconName) {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(iconName == "house" ? .black : .blue)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)

            }else {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(iconName == "house" ? .black : .blue)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)

            }
        } else {
            if let _  = UIImage(systemName: iconName){
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(iconName == "house" ? .black : .blue)
                    .padding(10)
                    .cornerRadius(15)
            } else {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(iconName == "house" ? .black : .blue)
                    .padding(10)
                    .cornerRadius(15)
            }
        }
    }
}
