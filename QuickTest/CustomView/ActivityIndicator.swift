//
//  ActivityIndicator.swift
//  HaaS
//
//  Created by ThinhLe on 19/05/2021.
//

import UIKit
import JGProgressHUD

class ActivityIndicator {
    static var shared = ActivityIndicator()
    var hud: JGProgressHUD?
    
    func show(text: String = "Loading".localized()) {
        guard !isVisible() else { return }
        hud?.dismiss()
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = nil
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        hud?.interactionType = .blockAllTouches
        hud?.backgroundColor = .init(white: 0.1, alpha: 0.5)
        hud?.show(in: window)
    }
    
    func isVisible() -> Bool {
        return hud?.isVisible ?? false
    }

    func dismiss() {
        hud?.dismiss()
        hud = nil
    }
}
