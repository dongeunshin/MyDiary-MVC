//
//  HomeViewController.swift
//  DiaryWithRealm
//
//  Created by dong eun shin on 2022/01/09.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    let realm = try! Realm()
    
    private let collectionViewControllerCellId = "collectionViewControllerCellId"
    let collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//      cv.backgroundColor = .red
      return cv
    }()
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewControllerCellId)
        
        view.addSubview(collectionView)
        
        collectionViewConstraints()
        
        let plusBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusbtnPressed(_:)))
        self.navigationItem.rightBarButtonItem = plusBtn
    }
    
    // MARK: - Constraints
    private func collectionViewConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
    }
    @objc private func plusbtnPressed(_ sender: Any) { self.navigationController?.pushViewController(DiaryWriteViewController(), animated: false)
    }
  }

  extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
          let vc = DiaryDetailViewController()
          vc.indexpath = indexPath
          self.navigationController?.pushViewController(vc, animated: false)
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var diary : Results<Diary>    // realm 데이터베이스를 불러올때는 반환타입이 Results<>타입이다.
        diary = realm.objects(Diary.self)    // realm.objects(모델클래스명.self)
        return diary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//      let cellText = stringArray[indexPath.item]
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewControllerCellId, for: indexPath) as! HomeCollectionViewCell
      
      var diary : Results<Diary>    // realm 데이터베이스를 불러올때는 반환타입이 Results<>타입이다.
      diary = realm.objects(Diary.self)    // realm.objects(모델클래스명.self)
      cell.label.text = diary[indexPath.row].title
      return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      let cellWidth = collectionView.bounds.width / 2 - 10
      let cellHeight = collectionView.bounds.height / 3
      return CGSize(width: cellWidth, height: cellHeight)
    }

      //핼 열 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//      return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//      return 10
//    }
  }

