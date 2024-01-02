import UIKit
import WidgetKit

class EditWidget: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setButtons()
    }
    
    func setButtons(){
        let changeFirstButton = UIButton()
        view.addSubview(changeFirstButton)
        changeFirstButton.translatesAutoresizingMaskIntoConstraints = false
        changeFirstButton.setTitle("Change First Icons in Widget", for: .normal)
        changeFirstButton.addTarget(self, action: #selector(self.changeFirstIcon), for: .touchUpInside)
        changeFirstButton.setTitleColor(.black, for: .normal)
        changeFirstButton.backgroundColor = .gray.withAlphaComponent(0.5)
        changeFirstButton.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            changeFirstButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            changeFirstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            changeFirstButton.heightAnchor.constraint(equalToConstant: 40),
            changeFirstButton.widthAnchor.constraint(equalToConstant: 300)
        ])
       
        let changeSecondButton = UIButton()
        view.addSubview(changeSecondButton)
        changeSecondButton.translatesAutoresizingMaskIntoConstraints = false
        changeSecondButton.setTitle("Change Second Icons in Widget", for: .normal)
        changeSecondButton.addTarget(self, action: #selector(self.changeSecondIcon), for: .touchUpInside)
        changeSecondButton.setTitleColor(.black, for: .normal)
        changeSecondButton.backgroundColor = .gray.withAlphaComponent(0.5)
        changeSecondButton.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            changeSecondButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            changeSecondButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            changeSecondButton.heightAnchor.constraint(equalToConstant: 40),
            changeSecondButton.widthAnchor.constraint(equalToConstant: 300)
        ])
      
        let changeThirdButton = UIButton()
        view.addSubview(changeThirdButton)
        changeThirdButton.translatesAutoresizingMaskIntoConstraints = false
        changeThirdButton.setTitle("Change Third Icons in Widget", for: .normal)
        changeThirdButton.addTarget(self, action: #selector(self.changeThirdIcon), for: .touchUpInside)
        changeThirdButton.setTitleColor(.black, for: .normal)
        changeThirdButton.backgroundColor = .gray.withAlphaComponent(0.5)
        changeThirdButton.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            changeThirdButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            changeThirdButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            changeThirdButton.heightAnchor.constraint(equalToConstant: 40),
            changeThirdButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func changeFirstIcon(){
        var index = 0
        SharedWidgetClass.shared.buttons.forEach { data in
            if data.buttonAction == .bus {
                SharedWidgetClass.shared.buttons[index] = SharedWidgetClass.shared.buttons[0]
                SharedWidgetClass.shared.buttons[0] = ButtonData(buttonAction: .bus)
                if #available(iOS 14.0, *) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                return
            }
            index  += 1
        }
    }
    
    @objc func changeSecondIcon(){
        var index = 0
        SharedWidgetClass.shared.buttons.forEach { data in
            if data.buttonAction == .bus {
                SharedWidgetClass.shared.buttons[index] = SharedWidgetClass.shared.buttons[1]
                SharedWidgetClass.shared.buttons[1] = ButtonData(buttonAction: .bus)
                if #available(iOS 14.0, *) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                return
            }
            index  += 1
        }
    }
    
    @objc func changeThirdIcon(){
        var index = 0
        SharedWidgetClass.shared.buttons.forEach { data in
            if data.buttonAction == .bus {
                SharedWidgetClass.shared.buttons[index] = SharedWidgetClass.shared.buttons[2]
                SharedWidgetClass.shared.buttons[2] = ButtonData(buttonAction: .bus)
                if #available(iOS 14.0, *) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                return
            }
            index  += 1
        }
    }
}
