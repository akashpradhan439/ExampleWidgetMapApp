import Foundation
import SwiftUI
import WidgetKit
import Intents
import UIKit

class SharedWidgetClass {
    static let shared = SharedWidgetClass()
    var buttons: [ButtonData] = []
    
    private init(){
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("house", forKey: "button1")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("cross.case.fill", forKey: "button2")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("cup.and.saucer.fill", forKey: "button3")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("building", forKey: "button4")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("pills.fill", forKey: "button5")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("bus", forKey: "button6")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("parkingsign", forKey: "button7")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("cocktail", forKey: "button8")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("fork.knife", forKey: "button9")
        UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!.set("banknote.fill", forKey: "button10")
        
        buttons.append(ButtonData(buttonAction: .home))
        buttons.append(ButtonData(buttonAction: .hospital))
        buttons.append(ButtonData(buttonAction: .coffee))
        buttons.append(ButtonData(buttonAction: .hotel))
        buttons.append(ButtonData(buttonAction: .medicine))
        buttons.append(ButtonData(buttonAction: .bus))
        buttons.append(ButtonData(buttonAction: .parking))
        buttons.append(ButtonData(buttonAction: .bar))
        buttons.append(ButtonData(buttonAction: .restaurant))
        buttons.append(ButtonData(buttonAction: .atm))
    }

    func setTopThree(first: ButtonData, second: ButtonData, third: ButtonData){
       
        let defaults = UserDefaults(suiteName: "group.com.Mappls.MapplsSDKDemo.DemoWidget")!

        var index = 0
        
        buttons.forEach { data in
            if data.buttonAction == first.buttonAction {
                buttons[index] = buttons[0]
                defaults.set(defaults.string(forKey: "button1")!, forKey: "button\(index+1)")
            }
            if data.buttonAction == second.buttonAction {
                buttons[index] = buttons[1]
                defaults.set(defaults.string(forKey: "button2")!, forKey: "button\(index+1)")
            }
            if data.buttonAction == third.buttonAction {
                buttons[index] = buttons[2]
                defaults.set(defaults.string(forKey: "button3")!, forKey: "button\(index+1)")
            }
            index += 1
        }

        defaults.set(first.buttonIcon.iconName, forKey: "button1")
        defaults.set(second.buttonIcon.iconName, forKey: "button2")
        defaults.set(third.buttonIcon.iconName, forKey: "button3")

        buttons[0] = first
        buttons[1] = second
        buttons[2] = third
        
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
            WidgetCenter.shared.reloadTimelines(ofKind: "CoolWidget")
        }
    }
}

struct ButtonData {
    var buttonIcon: IconImage
    
    var buttonAction: ButtonAction
    
    private init() {
        self.buttonIcon = IconImage(iconName: "bus")
        self.buttonAction = .bar
    }
    
    init(buttonAction: ButtonAction) {
        self.buttonAction = buttonAction
        switch buttonAction {
        case .hospital:
            self.buttonIcon = IconImage(iconName: "cross.case.fill")
        case .coffee:
            self.buttonIcon = IconImage(iconName: "cup.and.saucer.fill")
        case .hotel:
            self.buttonIcon = IconImage(iconName: "building")
        case .bus:
            self.buttonIcon = IconImage(iconName: "bus")
        case .medicine:
            self.buttonIcon = IconImage(iconName: "pills.fill")
        case .atm:
            self.buttonIcon = IconImage(iconName: "banknote.fill")
        case .parking:
            self.buttonIcon = IconImage(iconName: "parkingsign")
        case .bar:
            self.buttonIcon = IconImage(iconName: "cocktail")
        case .restaurant:
            self.buttonIcon = IconImage(iconName: "fork.knife")
        case .home:
            self.buttonIcon = IconImage(iconName: "house")
        }
    }
}

enum ButtonAction {
    case hospital
    case coffee
    case hotel
    case bus
    case medicine
    case atm
    case parking
    case bar
    case restaurant
    case home
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
            }else {
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
