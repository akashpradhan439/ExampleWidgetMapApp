import Foundation
import SwiftUI

class SharedWidgetClass {
    static let shared = SharedWidgetClass()

    private init(){
        buttons.append(ButtonData(buttonAction: .atm))
        buttons.append(ButtonData(buttonAction: .bar))
        buttons.append(ButtonData(buttonAction: .hospital))
        buttons.append(ButtonData(buttonAction: .bus))
        buttons.append(ButtonData(buttonAction: .coffee))
        buttons.append(ButtonData(buttonAction: .medicine))
        buttons.append(ButtonData(buttonAction: .parking))
        buttons.append(ButtonData(buttonAction: .hotel))
        buttons.append(ButtonData(buttonAction: .restaurant))
        buttons.append(ButtonData(buttonAction: .home))
    }
    
    func setTopThree(first: ButtonData, second: ButtonData, third: ButtonData){
        
    }
    
    func addToTopThree(buttonData: ButtonData){
        
    }
    
    var buttons: [ButtonData] = []
}

struct ButtonData {
    private init() {
        self.buttonIcon = ""
        self.buttonAction = .bar
    }

    init(buttonAction: ButtonAction) {
        self.buttonAction = buttonAction
        switch buttonAction {
        case .hospital:
            self.buttonIcon = "cross.case.fill"
        case .coffee:
            self.buttonIcon = "cup.and.saucer.fill"
        case .hotel:
            self.buttonIcon = "building"
        case .bus:
            self.buttonIcon = "bus"
        case .medicine:
            self.buttonIcon = "pills.fill"
        case .atm:
            self.buttonIcon = "banknote.fill"
        case .parking:
            self.buttonIcon = "parkingsign"
        case .bar:
            self.buttonIcon = "figure.dance"
        case .restaurant:
            self.buttonIcon = "fork.knife"
        case .home:
            self.buttonIcon = "house"
        }
    }
    var buttonIcon: String
    var buttonAction: ButtonAction
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
