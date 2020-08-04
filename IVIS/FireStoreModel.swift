//
//  FireStoreModel.swift
//  IVIS
//
//  Created by mac on 2020/08/04.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

struct FireStoreModel {

    var email: String?
    var profileImageUrl: String?
    var githubUrl: String?
    var uid: String
    
    init?(dictionary: [String: Any]) {
        guard let uid = dictionary["uid"] as? String else { return nil }
        self.uid = uid

        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        self.githubUrl = dictionary["githubUrl"] as? String
    }

}
