//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

/**
UIView that shows all product details in a list cell
*/
final class ProductListView: UIView, ReusableView {

	static var reuseID: String = "ProductListViewIdentifier"

	// MARK: Properties

	/// title for product
	internal lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 22.0, weight: .regular)
		label.numberOfLines = 2
		label.lineBreakMode = .byTruncatingTail
		label.accessibilityIdentifier = "productTitle"
		return label
	}()

	/// seperator line
	internal lazy var line: UIView = {
		let lineView: UIView = UIView()
		lineView.backgroundColor = .lightGray
		lineView.translatesAutoresizingMaskIntoConstraints = false
		return lineView
	}()

	/// sale price label
	internal lazy var salePriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 26.0, weight: .medium)
		label.textColor = .targetBullseyeRedColor
		label.accessibilityIdentifier = "productSalePrice"
		return label
	}()

	// original price for product
	internal lazy var originalPriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .gray
		label.accessibilityIdentifier = "originalSalePrice"
		return label
	}()

	/// stack view for prices
	internal lazy var pricesStackView: UIStackView = {
		let stack: UIStackView = UIStackView()
		stack.distribution = .fill
		stack.axis = .vertical
		stack.spacing = 6
		stack.setContentHuggingPriority(.defaultLow, for: .vertical)
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	/// product image
	internal lazy var productImage: UIImageView = {
		let imageView: UIImageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.accessibilityIdentifier = "productImage"
		return imageView
	}()

	// MARK: Initaializer
	init() {
		super.init(frame: .zero)
		accessibilityIdentifier = "ProductListCellView"
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Setup

	// Adds views in view heirachy
	func setupView() {
		self.layer.cornerRadius = 10
		self.layer.borderColor = UIColor.gray.cgColor
		self.layer.borderWidth = 0.5

		addSubview(productImage)
		addSubview(titleLabel)
		addSubview(line)

		pricesStackView.addArrangedSubview(salePriceLabel)
		pricesStackView.addArrangedSubview(originalPriceLabel)
		addSubview(pricesStackView)
	}

	/// sets font based on viewState
	func setPriceLabelFont(font: UIFont) {
		originalPriceLabel.font = font
	}

	/// sets up constraints
	func setupConstraints() {
		/// image
		productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
		productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
		productImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
		productImage.widthAnchor.constraint(equalToConstant: 100.0).isActive = true

		/// title
		titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 16).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true

		/// line
		line.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
		line.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		line.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		line.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

		/// pricesStackView
		pricesStackView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 16).isActive = true
		pricesStackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 16).isActive = true
		pricesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
		pricesStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true

	}
}
