//
//  DateToStringExtension.swift
//  PartyApp
//
//  Created by user1 on 13.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        let date = self
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
}
