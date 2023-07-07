import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(getListButton)
        setUpConstraints()
    }
    
    lazy var getListButton: UIButton = {
        let getListButton = UIButton(type: .system)
        getListButton.setTitle("GetList", for: .normal)
        getListButton.backgroundColor = .cyan
        
        getListButton.addTarget(self, action: #selector(getListTapped), for: .touchUpInside)
        
        return getListButton
    }()
    
    @objc func getListTapped() {
        print("start")
        
//        var ll = TodoItem(text: "qwert", importance: .important, created: Date())
//
//        DefaultNetworkService().postData(data: ll.json, completion:) { result in
//            switch result {
//            case .success(let data):
//                print("Отправленны данные: \(data)")
//            case .failure(let error):
//                print("Произошла ошибка: \(error)")
//            }
//        }
        
//        print("end")
        DefaultNetworkService().getData(completion:) { result in
            switch result {
            case .success(let data):
                print("Получены данные: \(data)")
            case .failure(let error):
                print("Произошла ошибка: \(error)")
            }
        }
        print("end")


    }
    
    func setUpConstraints() {
        getListButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            getListButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            getListButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            getListButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            getListButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
