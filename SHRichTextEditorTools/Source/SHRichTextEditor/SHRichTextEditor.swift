//
//  SHRichTextEditor.swift
//  SHRichTextEditor
//
//  Created by Susmita Horrow on 30/01/17.
//  Copyright © 2017 hsusmita. All rights reserved.
//

import Foundation
import UIKit

open class SHRichTextEditor: NSObject, RichTextEditor {
	public let textView: UITextView
	public let toolBar = UIToolbar()
	public let textViewDelegate = TextViewDelegate()
	public var toolBarItems: [ToolBarItem] = [] {
		didSet {
			self.configure()
		}
	}

	public let toolBarSelectedTintColor: UIColor
	public let toolBarDefaultTintColor: UIColor
	private var defaultImageInputHandler: ImageInputHandler
	private var defaultLinkInputHandler: LinkInputHandler

	public static let defaultBoldButtonType: ToolBarButton.ButtonType = {
		let bundle = Bundle(for: SHRichTextEditor.classForCoder())
		if let picureIcon = UIImage(named: "Bold", in: bundle, compatibleWith: nil) {
			return ToolBarButton.ButtonType.image(image: picureIcon)
		} else {
			return ToolBarButton.ButtonType.title(title: "Bold")
		}
	}()

	public static let defaultItalicButtonType: ToolBarButton.ButtonType = {
		let bundle = Bundle(for: SHRichTextEditor.classForCoder())
		if let picureIcon = UIImage(named: "Italic", in: bundle, compatibleWith: nil) {
			return ToolBarButton.ButtonType.image(image: picureIcon)
		} else {
			return ToolBarButton.ButtonType.title(title: "Italic")
		}
	}()

	public static let defaultIndentationButtonType: ToolBarButton.ButtonType = {
		let bundle = Bundle(for: SHRichTextEditor.classForCoder())
		if let picureIcon = UIImage(named: "Bullet", in: bundle, compatibleWith: nil) {
			return ToolBarButton.ButtonType.image(image: picureIcon)
		} else {
			return ToolBarButton.ButtonType.title(title: "Indentation")
		}
	}()

	public static let defaultLinkButtonType: ToolBarButton.ButtonType = {
		let bundle = Bundle(for: SHRichTextEditor.classForCoder())
		if let picureIcon = UIImage(named: "Link", in: bundle, compatibleWith: nil) {
			return ToolBarButton.ButtonType.image(image: picureIcon)
		} else {
			return ToolBarButton.ButtonType.title(title: "Link")
		}
	}()

	public static var defaultImageButtonType: ToolBarButton.ButtonType = {
		let bundle = Bundle(for: SHRichTextEditor.classForCoder())
		if let picureIcon = UIImage(named: "Picture", in: bundle, compatibleWith: nil) {
			return ToolBarButton.ButtonType.image(image: picureIcon)
		} else {
			return ToolBarButton.ButtonType.title(title: "Picture")
		}
	}()

	public init(textView: UITextView,
				defaultTintColor: UIColor = .gray,
				selectedTintColor: UIColor = UIColor(red: 57/255.0, green: 200/255.0, blue: 129/255.0, alpha: 1)) {
		self.textView = textView
		self.toolBarDefaultTintColor = defaultTintColor
		self.toolBarSelectedTintColor = selectedTintColor
		self.defaultImageInputHandler = TextViewImageInputHandler(textView: self.textView)
		self.defaultLinkInputHandler = LinkInputAlert()
		super.init()
	}

	public func boldBarItem(type: ToolBarButton.ButtonType = SHRichTextEditor.defaultBoldButtonType,
							actionOnSelection: ((ToolBarButton, Bool) -> Void)? = nil) -> ToolBarItem {
		let defaultAction: ((ToolBarButton, Bool) -> Void) = { [unowned self] (item, isSelected) in
			item.barButtonItem.tintColor = isSelected ? self.toolBarSelectedTintColor : self.toolBarDefaultTintColor
		}
		return ToolBarButton.configureBoldToolBarButton(
			type: type,
			actionOnSelection: actionOnSelection ?? defaultAction,
			textView: self.textView,
			textViewDelegate: self.textViewDelegate)
	}

	public func italicBarItem(type: ToolBarButton.ButtonType = SHRichTextEditor.defaultItalicButtonType,
							  actionOnSelection: ((ToolBarButton, Bool) -> Void)? = nil) -> ToolBarItem {
		let defaultAction: ((ToolBarButton, Bool) -> Void) = { [unowned self] (item, isSelected) in
			item.barButtonItem.tintColor = isSelected ? self.toolBarSelectedTintColor : self.toolBarDefaultTintColor
		}
		return ToolBarButton.configureItalicToolBarButton(
			type: type,
			actionOnSelection: actionOnSelection ?? defaultAction,
			textView: self.textView,
			textViewDelegate: self.textViewDelegate)
	}

	public func indentationBarItem(type: ToolBarButton.ButtonType = SHRichTextEditor.defaultIndentationButtonType,
								   actionOnSelection: ((ToolBarButton, Bool) -> Void)? = nil) -> ToolBarItem {
		let defaultAction: ((ToolBarButton, Bool) -> Void) = { [unowned self] (item, isSelected) in
			item.barButtonItem.tintColor = isSelected ? self.toolBarSelectedTintColor : self.toolBarDefaultTintColor
		}
		return ToolBarButton.configureIndentationToolBarButton(
			type: type,
			actionOnSelection: actionOnSelection ?? defaultAction,
			textView: self.textView,
			textViewDelegate: self.textViewDelegate)
	}

	public func linkToolBarItem(type: ToolBarButton.ButtonType = SHRichTextEditor.defaultLinkButtonType,
								actionOnSelection: ((ToolBarButton, Bool) -> Void)? = nil,
								linkInputHandler: LinkInputHandler? = nil) -> ToolBarItem {
		let defaultAction: ((ToolBarButton, Bool) -> Void) = { [unowned self] (item, isSelected) in
			item.barButtonItem.tintColor = isSelected ? self.toolBarSelectedTintColor : self.toolBarDefaultTintColor
		}
		return ToolBarButton.configureLinkToolBarButton(
			type: type,
			actionOnSelection: actionOnSelection ?? defaultAction,
			linkInputHandler: linkInputHandler ?? self.defaultLinkInputHandler,
			textView: self.textView,
			textViewDelegate: self.textViewDelegate)
	}

	public func imageToolBarItem(type: ToolBarButton.ButtonType = SHRichTextEditor.defaultImageButtonType,
								 actionOnSelection: ((ToolBarButton, Bool) -> Void)? = nil,
								 imageInputHandler: ImageInputHandler? = nil) -> ToolBarItem {
		let defaultAction: ((ToolBarButton, Bool) -> Void) = { [unowned self] (item, isSelected) in
			item.barButtonItem.tintColor = isSelected ? self.toolBarSelectedTintColor : self.toolBarDefaultTintColor
		}
		return ToolBarButton.configureImageToolBarButton(
			type: type,
			actionOnSelection: actionOnSelection ?? defaultAction,
			imageInputHandler: imageInputHandler ?? self.defaultImageInputHandler,
			textView: self.textView,
			textViewDelegate: self.textViewDelegate)
	}

	public let fixedSpaceToolBarItem = ToolBarSpacer(type: .fixed)
	public let flexibleSpaceToolBarItem = ToolBarSpacer(type: .flexible)
}
