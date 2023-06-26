//import UIKit
//
//class RadioButtonCell: UICollectionViewCell {
//    let radioButton = UISwitch()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(radioButton)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
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
//        cell.backgroundColor = .red
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
//        // Load data into the collection view
//        let data = ["Option 1", "Option 2", "Option 3"]
//        dataSource.updateData(data)
//        collectionView.dataSource = dataSource
//    }
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: view.frame.width, height: 50)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(RadioButtonCell.self, forCellWithReuseIdentifier: "RadioButtonCell")
//        collectionView.delegate = self // Implement any other delegate methods you need
//        
//        layout.collectionView?.frame = view.frame
//        return collectionView
//    }()
//}
