//
//  HomeCollectionViewCell.swift
//  DiaryWithRealm
//
//  Created by dong eun shin on 2022/01/09.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let label: UILabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
      addViews()
      setConstraints()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func setup(){
      backgroundColor = .blue
      label.textAlignment = .center
    }
    
    private func addViews(){
      addSubview(label)
    }
    
    private func setConstraints(){
      labelConstraints()
    }
    
    // MARK: - Constraints
    private func labelConstraints(){
      label.translatesAutoresizingMaskIntoConstraints = false
      label.widthAnchor.constraint(equalToConstant: 50).isActive = true
      label.heightAnchor.constraint(equalToConstant: 50).isActive = true
      label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
  }
