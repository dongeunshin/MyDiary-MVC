//
//  Diary.swift
//  DiaryWithRealm
//
//  Created by dong eun shin on 2022/01/10.
//
import Foundation
import RealmSwift

class Diary : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var contents: String = ""
}
