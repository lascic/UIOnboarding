//
//  UIViewController+Ext.swift
//  UIOnboarding Demo
//
//  Created by Lukman Aščić on 14.02.22.
//

import UIKit

extension UIViewController {
    func pin(_ view: UIView, toEdgesOf parent: UIView) {
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    }
    
    func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        let window = UIApplication.shared.windows.filter {
            $0.isKeyWindow
        }.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }
}
