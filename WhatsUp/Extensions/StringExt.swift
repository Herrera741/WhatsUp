//
//  StringExt.swift
//  WhatsUp
//
//  Created by Sergio Herrera on 5/18/23.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
