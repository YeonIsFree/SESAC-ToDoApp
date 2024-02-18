//
//  PassDataDelegate.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/15.
//

import UIKit

protocol PassDataDelegate where Self: UIViewController {
    var changedValue: ((String) -> Void)? { get set }
}
