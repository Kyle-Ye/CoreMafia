//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/1.
//

import Foundation
import os

// TODO: - ADD if to decide whether using Logger or LogHistory API
// let logger = Logger()

public class LogHistory {
    private var histories: [[String]] = [[]]

    func info(_ message: String) {
        histories[count - 1].append(message)
    }

    func warning(_ message: String) {
        histories[count - 1].append("WARNING: \(message)")
    }

    func error(_ message: String) {
        histories[count - 1].append("ERROR: \(message)")
    }

    func next() {
        histories.append([])
    }

    public var count: Int {
        histories.count
    }

    public subscript(index: Int) -> [String] {
        return histories[index]
    }
}
