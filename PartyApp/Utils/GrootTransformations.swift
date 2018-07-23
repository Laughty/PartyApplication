//
//  transfo.swift
//  PartyApp
//
//  Created by user1 on 23/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import Groot

func toDate(_ value: String) -> Date? {
    //    let dateFormatterGet = DateFormatter()
    //    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //    let date: Date? = dateFormatterGet.date(from: value)
    return Date()
}
func toInt32(_ value: String) -> Int32? {
    return Int32(value)
}
func toDouble(_ value: String) -> Double? {
    return Double(value)
}
func toLatitude(_ value: [Double]) -> Double? {
    return value[0]
}

func toLongitude(_ value: [Double]) -> Double? {
    return value[1]
}
