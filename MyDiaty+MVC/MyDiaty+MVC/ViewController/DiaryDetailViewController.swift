//
//  DiaryDetailViewController.swift
//  DiaryWithRealm
//
//  Created by dong eun shin on 2022/01/10.
//

import UIKit
import RealmSwift

class DiaryDetailViewController: UIViewController {
    
    let realm = try! Realm()
    
    var indexpath: IndexPath?

    let titleLabel = UILabel()
    let contentsLabel = UILabel()
    let titleField: UITextField = UITextField()
    let contentsField: UITextField = UITextField()
    let editBtn: UIButton = UIButton()
    let deleteBtn: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiSetup()
    }
    func uiSetup(){
        var diary : Results<Diary>    // realm 데이터베이스를 불러올때는 반환타입이 Results<>타입이다.
        diary = realm.objects(Diary.self)    // realm.objects(모델클래스명.self)
        
        let savedBtn = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(savedBtnPressed(_:)))
        self.navigationItem.rightBarButtonItem = savedBtn
        
        titleLabel.text = "Title"
        contentsLabel.text = "Contents"
        editBtn.setTitle("Edit", for: .normal)
        deleteBtn.setTitle("Delete", for: .normal)
        editBtn.backgroundColor = .red
        deleteBtn.backgroundColor = .red
        editBtn.addTarget(self, action: #selector(editBtnPressed(_:)), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteBtnPressed(_:)), for: .touchUpInside)
        
        guard let i = self.indexpath?.row else {return}
        titleField.text = diary[i].title
        contentsField.text = diary[i].contents
        
        titleField.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        titleField.borderStyle = .roundedRect
        titleField.clearButtonMode = .always //글 삭제 버튼
        
        contentsField.frame = CGRect(x: 100, y: 100, width: 50, height: 100)
        contentsField.borderStyle = .roundedRect
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        contentsField.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        editBtn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(titleField)
        view.addSubview(contentsLabel)
        view.addSubview(contentsField)
        view.addSubview(deleteBtn)
        view.addSubview(editBtn)
        
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        
        titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        titleField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        titleField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
        
        contentsLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20).isActive = true
        contentsLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        contentsLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true

        contentsField.topAnchor.constraint(equalTo: contentsLabel.bottomAnchor, constant: 30).isActive = true
        contentsField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        contentsField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
        
        editBtn.topAnchor.constraint(equalTo: contentsField.bottomAnchor, constant: 50).isActive = true
        editBtn.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        editBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
        
        deleteBtn.topAnchor.constraint(equalTo: editBtn.bottomAnchor, constant: 30).isActive = true
        deleteBtn.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        deleteBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
    }
                                       
    @objc private func savedBtnPressed(_ sender: Any) { self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func editBtnPressed(_ sender: Any) {
        var diary : Results<Diary>
        diary = realm.objects(Diary.self)
        do {
            try realm.write {
                guard let i = self.indexpath?.row else {return}
                diary[i].title = self.titleField.text ?? "tmptitle"
                diary[i].contents = self.contentsField.text ?? "tmptitle"
                }
        } catch {
                print("Error")
        }
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func deleteBtnPressed(_ sender: Any) {
        var diary : Results<Diary>
        diary = realm.objects(Diary.self)
        do {
                try realm.write {
                    guard let i = self.indexpath?.row else {return}
                    realm.delete(diary[i])
                }
        } catch {
                print("Error")
        }
        
        self.navigationController?.popViewController(animated: false)
    }
}
