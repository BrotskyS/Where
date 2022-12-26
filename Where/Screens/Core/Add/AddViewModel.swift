//
//  AddViewModel.swift
//  Where
//
//  Created by Sergiy Brotsky on 03.12.2022.
//

import Foundation
import RxSwift
import RxCocoa

class AddViewModel {
    let titleSubject = BehaviorRelay<String?>(value: "")
    let descriptionSubject = BehaviorRelay<String?>(value: "")

    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(titleSubject, descriptionSubject) { title, description in
            guard title != nil && description != nil  else {
                return false
            }

            return !(title!.isEmpty) && description!.isEmpty
        }
    }
}
 
