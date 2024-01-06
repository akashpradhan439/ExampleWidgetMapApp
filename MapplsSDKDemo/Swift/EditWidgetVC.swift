import UIKit

class EditWidget: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setButtons()
    }

    func setButtons(){
        let changeSecondButton = UIButton()
        view.addSubview(changeSecondButton)
        changeSecondButton.translatesAutoresizingMaskIntoConstraints = false
        changeSecondButton.setTitle("Add to Top Three", for: .normal)
        changeSecondButton.addTarget(self, action: #selector(self.changeSecondIcon), for: .touchUpInside)
        changeSecondButton.setTitleColor(.black, for: .normal)
        changeSecondButton.setTitleColor(.blue, for: .highlighted)
        NSLayoutConstraint.activate([
            changeSecondButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            changeSecondButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            changeSecondButton.heightAnchor.constraint(equalToConstant: 40),
            changeSecondButton.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    @objc func changeSecondIcon(){
        SharedWidgetClass.shared.setTopThree(first: ButtonData(buttonAction: .medicine), second: ButtonData(buttonAction: .hotel), third: ButtonData(buttonAction: .hospital))
    }
}
