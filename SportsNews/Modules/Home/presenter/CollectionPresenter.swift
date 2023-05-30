//
//  CollectionPresenter.swift
//  SportsNews
//
//  Created by Nada youssef on 30/05/2023.
//

import Foundation
class CollectionPresenter{
    weak var view : CollectionProtocol!
    func attachView(view: CollectionProtocol){
        self.view = view
    }
}
