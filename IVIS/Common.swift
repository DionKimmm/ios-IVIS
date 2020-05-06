//
//  Common.swift
//  iOS12_SignIn
//
//  Created by mac on 2020/04/13.
//  Copyright © 2020 dionkim. All rights reserved.
//
import UIKit

// 공통적으로 사용되는 것들을 묶어 놓은 파일입니다.
extension Dictionary {
    var queryString: String {
        var output = ""
        for (key, value) in self {
            output = output + "\(key)=\(value)&"
        }
        output = String(output.dropLast()) // 마지막의 &은 필요가 없습니다.
        return output
    }
}
