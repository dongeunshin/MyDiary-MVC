//
//  DiaryWriteViewController.swift
//  DiaryWithRealm
//
//  Created by dong eun shin on 2022/01/09.
//

import UIKit
import RealmSwift

class DiaryWriteViewController: UIViewController {
    
    let titleLabel = UILabel()
    let contentsLabel = UILabel()
    let titleField: UITextField = UITextField()
    let contentsField: UITextField = UITextField()
    
    let weatherLabel = UILabel()
    
//    var realm: Realm{
//        let r = try! Realm()
//        return r
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    
    func uiSetup(){
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnPressed(_:)))
        self.navigationItem.rightBarButtonItem = doneBtn
        
        titleLabel.text = "Title"
        contentsLabel.text = "Contents"
        weatherLabel.text = "오늘의 날씨: "
        
        titleField.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        titleField.borderStyle = .roundedRect
        titleField.clearButtonMode = .always //글 삭제 버튼
        
        contentsField.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        contentsField.borderStyle = .roundedRect
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        contentsField.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(titleField)
        view.addSubview(contentsLabel)
        view.addSubview(contentsField)
        view.addSubview(weatherLabel)
        
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
        contentsField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        contentsField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        
        weatherLabel.topAnchor.constraint(equalTo: contentsField.bottomAnchor, constant: 30).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        weatherLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc private func doneBtnPressed(_ sender: Any) {
        let realm = try! Realm()
        let newDiary = Diary()
        newDiary.title =  self.titleField.text ?? "tmptitle"
        newDiary.contents = self.contentsField.text ?? "tmpcontents"
        
        do{
            // realm.write{}는 git에서 commit을 해주는 것과 비슷하다.
            try realm.write{ realm.add(newDiary) }
        } catch {
            print("Error Add \(error)")
        }
        
        self.navigationController?.popViewController(animated: false)
    }
}
