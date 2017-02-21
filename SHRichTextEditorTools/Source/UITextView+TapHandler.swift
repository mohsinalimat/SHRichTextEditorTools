//
//  UITextView+TapHandler.swift
//  SHRichTextEditorTools
//
//  Created by Susmita Horrow on 20/02/17.
//  Copyright © 2017 hsusmita. All rights reserved.
//

import Foundation
import UIKit

private var currentTappedIndexKey: UInt8 = 0

public extension UITextView {
	static let UITextViewTextDidChangeTap =  Notification.Name(rawValue: "UITextViewTextDidChangeTap")
	
	public var touchEnabled: Bool {
		get {
			guard let gestureRecognizers = gestureRecognizers else {
				return false
			}
			return !gestureRecognizers.filter({ $0.isKind(of: UITapGestureRecognizer.self) }).isEmpty
		}
		
		set {
			let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
			tap.delegate = self
			addGestureRecognizer(tap)
		}
	}
	
	private(set) var currentTappedIndex: Int? {
		get {
			return objc_getAssociatedObject(self, &currentTappedIndexKey) as? Int
		}
		
		set {
			objc_setAssociatedObject(self, &currentTappedIndexKey, newValue, .OBJC_ASSOCIATION_COPY)
		}
		
	}
	
	func handleTap(_ sender: UITapGestureRecognizer) {
		let location = sender.location(in: self)
		if let index = characterIndex(at: location), index < textStorage.length {
			currentTappedIndex = index
			let notification: Notification = Notification(name: UITextView.UITextViewTextDidChangeTap, object: self, userInfo: nil)
			NotificationCenter.default.post(notification)
		}
	}
}

extension UITextView: UIGestureRecognizerDelegate {
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
