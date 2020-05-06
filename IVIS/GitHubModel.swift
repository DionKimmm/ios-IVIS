//
//  GitHubModel.swift
//  UITest
//
//  Created by mac on 2020/04/16.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

struct GitHubModel {

    var name: String
    var photo: UIImage?
    var url: String
    
//    photo =
    
    init() {
        name = ""
        url = ""
    }
    
    init(name: String, photo: UIImage?, url: String) {
        self.name = name
        self.photo = photo ?? UIImage(named: "HasNoPhoto")
        self.url = url
    }

}
