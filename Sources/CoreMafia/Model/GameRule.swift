//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/16.
//

import Foundation
public class GameRule: ObservableObject {
    // MARK: - Game

    @Published public var willSpecialClaim: Bool = true
    @Published public var willSeerWhiteListClaim: Bool = true
    @Published public var willSaviorWhiteListClaim: Bool = false
    @Published public var willWitchWhiteListClaim: Bool = true

    // MARK: - Savior

    public enum SaviorRule: String, CaseIterable, Identifiable {
        case allNotSame
        case otherCanSame
        public var id: SaviorRule { self }
    }

    @Published public var saviorRule: SaviorRule = .otherCanSame

    // MARK: - Witch

    @Published public var witchAntidote: Int = 1
    @Published public var witchPoison: Int = 1

    public init() {
    }
}
