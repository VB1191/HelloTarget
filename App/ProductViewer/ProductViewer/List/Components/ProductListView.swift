//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo


final class ProductListView: UIView, ReusableView {

	static var reuseID: String = "ProductListViewIdentifier"

	/// TODO: accessibility ids
	internal lazy var rightStackView: UIStackView = {
		let stack: UIStackView = UIStackView()
		stack.distribution = .fill
		stack.axis = .vertical
		stack.spacing = 16
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	internal lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 22.0, weight: .regular)
		label.numberOfLines = 0
		label.lineBreakMode = .byTruncatingTail
		label.accessibilityIdentifier = "productTitle"
		return label
	}()

	internal lazy var line: UIView = {
		let lineView: UIView = UIView()
		lineView.backgroundColor = .lightGray
		lineView.translatesAutoresizingMaskIntoConstraints = false
		return lineView
	}()

	internal lazy var salePriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 26.0, weight: .medium)
		label.setContentHuggingPriority(.defaultHigh, for: .vertical)
		label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		label.textColor = .targetRed
		label.accessibilityIdentifier = "productSalePrice"
		return label
	}()

	internal lazy var originalPriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		label.textColor = .gray
		label.accessibilityIdentifier = "originalSalePrice"
		return label
	}()

	internal lazy var pricesStackView: UIStackView = {
		let stack: UIStackView = UIStackView()
		stack.distribution = .fill
		stack.axis = .vertical
		stack.spacing = 6
		stack.setContentHuggingPriority(.defaultHigh, for: .vertical)
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	internal lazy var productImage: UIImageView = {
		let imageView: UIImageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.accessibilityIdentifier = "productImage"
		return imageView
	}()

	init() {
		super.init(frame: .zero)
		accessibilityIdentifier = "ProductListCellView"
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

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

	func setPriceLabelFont(font: UIFont) {
		originalPriceLabel.font = font
	}

	func setupConstraints() {
		/// image
		productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
		productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
		productImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
		productImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true

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
