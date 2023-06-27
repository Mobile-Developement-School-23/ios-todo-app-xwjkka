//import UIKit
//
//class RadioButtonCell: UICollectionViewCell {
//    let radioButton = UISwitch()
//    let textLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(radioButton)
//        addSubview(textLabel)
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupCellConstraints() {
//        
//    }
//}
//
//class RadioButtonCollectionViewDataSource: NSObject, UICollectionViewDataSource {
//    private var selectedIndex: Int?
//    private var data: [String] = []
//
//    func updateData(_ newData: [String]) {
//        data = newData
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RadioButtonCell", for: indexPath) as! RadioButtonCell
//        cell.radioButton.isOn = indexPath.row == selectedIndex
//        cell.textLabel.text = data[indexPath.row]
//
////        cell.frame.
////        cell.backgroundColor = .red
////        cell.self.largeContentTitle = "collectionView."
//        
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedIndex = indexPath.row
//        collectionView.reloadData()
//    }
//}
//
//
//class ViewController: UIViewController, UICollectionViewDelegate {
//    
//    private lazy var dataSource = RadioButtonCollectionViewDataSource()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let data = ["Option 1", "Option 2", "Option 3"]
//        dataSource.updateData(data)
//        collectionView.dataSource = dataSource
//        view.addSubview(collectionView)
//    }
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: view.frame.width, height: 50)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(RadioButtonCell.self, forCellWithReuseIdentifier: "RadioButtonCell")
//        collectionView.delegate = self
//        
//        layout.collectionView?.frame = view.frame
//        return collectionView
//    }()
//}
