import UIKit

class EditWidget: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setButtons()
    }

    func setButtons(){
        let button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Top Three", for: .normal)
        button.addTarget(self, action: #selector(self.changeWidget), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.cyan, for: .highlighted)
        button.backgroundColor = .cyan.withAlphaComponent(0.4)
        button.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc func changeWidget(){
        guard var buttonsData = try? JSONDecoder().decode(ButtonsData.self, from: SharedWidgetClass.shared.primaryData) else {
            return
        }
        let but1 = buttonsData.but1
        buttonsData.but1 = buttonsData.but3
        buttonsData.but3 = but1
        SharedWidgetClass.shared.changeWidget(buttonsData: buttonsData)
    }
}
