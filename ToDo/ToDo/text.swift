////import UIKit
////
////class RadioButtonCell: UICollectionViewCell {
////    let radioButton = UISwitch()
////    let textLabel = UILabel()
////
////    override init(frame: CGRect) {
////        super.init(frame: frame)
////        addSubview(radioButton)
////        addSubview(textLabel)
////        
////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////    
////    private func setupCellConstraints() {
////        
////    }
////}
////
////class RadioButtonCollectionViewDataSource: NSObject, UICollectionViewDataSource {
////    private var selectedIndex: Int?
////    private var data: [String] = []
////
////    func updateData(_ newData: [String]) {
////        data = newData
////    }
////
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return data.count
////    }
////
////    func numberOfSections(in collectionView: UICollectionView) -> Int {
////        return 1
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RadioButtonCell", for: indexPath) as! RadioButtonCell
////        cell.radioButton.isOn = indexPath.row == selectedIndex
////        cell.textLabel.text = data[indexPath.row]
////
//////        cell.frame.
//////        cell.backgroundColor = .red
//////        cell.self.largeContentTitle = "collectionView."
////        
////        return cell
////    }
////
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        selectedIndex = indexPath.row
////        collectionView.reloadData()
////    }
////}
////
////
////class ViewController: UIViewController, UICollectionViewDelegate {
////    
////    private lazy var dataSource = RadioButtonCollectionViewDataSource()
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        let data = ["Option 1", "Option 2", "Option 3"]
////        dataSource.updateData(data)
////        collectionView.dataSource = dataSource
////        view.addSubview(collectionView)
////    }
////    
////    private lazy var collectionView: UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .vertical
////        layout.itemSize = CGSize(width: view.frame.width, height: 50)
////        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        collectionView.register(RadioButtonCell.self, forCellWithReuseIdentifier: "RadioButtonCell")
////        collectionView.delegate = self
////        
////        layout.collectionView?.frame = view.frame
////        return collectionView
////    }()
////}
//import UIKit
//
//class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ listToDoTable: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    func tableView(_ listToDoTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = listToDoTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//        cell.textLabel?.text = data[indexPath.row]
//        return cell
//    }
//    
//    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
//    
//    private lazy var newButton: UIButton = {
//        let newButton = UIButton()
//        newButton.setTitle("Новое", for: .normal)
//        newButton.setTitleColor(#colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), for: .normal)
//        newButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        newButton.contentHorizontalAlignment = .left
//        newButton.contentEdgeInsets = UIEdgeInsets(top: 16,left: 28,bottom: 16,right: 28)
//        return newButton
//    }()
//    
//    private lazy var listToDoTable: UITableView = {
//        let listToDoTable = UITableView()
//        listToDoTable.delegate = self
//        listToDoTable.dataSource = self
//        listToDoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
//        listToDoTable.tableFooterView = newButton
//        listToDoTable.tableFooterView?.frame = CGRect(x: 0, y: 0, width: listToDoTable.frame.width, height: 56)
//        
//        listToDoTable.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        listToDoTable.layer.cornerRadius = 16
//        return listToDoTable
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.addSubview(listToDoTable)
//        
//        listToDoTable.translatesAutoresizingMaskIntoConstraints = false
//        listToDoTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        listToDoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        listToDoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        listToDoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//    }
//    
//    @objc func addButtonTapped() {
//        print("New button tapped")
//    }
//    
//}
