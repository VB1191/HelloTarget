//
//  ProductDetailView.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

/**
UIView that shows all product details
*/
final class ProductDetailView: UIView {

	// MARK: Properties

	/// Label for product title
	internal lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 26.0, weight: .medium)
		label.textColor = .targetBullseyeRedColor
		label.numberOfLines = 0
		label.textAlignment = .center
		label.accessibilityIdentifier = "productDetailTitle"
		return label
	}()

	/// Image for product
	internal lazy var productImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.accessibilityIdentifier = "productDetailImage"
		return imageView
	}()

	/// Label for sale price if any
	internal lazy var salePriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 26.0, weight: .medium)
		label.textColor = .targetBullseyeRedColor
		label.textAlignment = .center
		label.accessibilityIdentifier = "productDeatilSalePrice"
		return label
	}()

	/// Label for original price of product
	internal lazy var originalPriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 22.0, weight: .medium)
		label.textColor = .targetNeutralGrayColor
		label.textAlignment = .center
		label.accessibilityIdentifier = "productDetailOriginalPrice"
		return label
	}()

	/// stack view for sale price and original price
	internal lazy var pricesStackView: UIStackView = {
		let stack: UIStackView = UIStackView()
		stack.distribution = .fill
		stack.alignment = .center
		stack.axis = .vertical
		stack.spacing = 6
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.accessibilityIdentifier = "productDetailPricesStack"
		return stack
	}()

	/// stack view for sale price and original price
	internal lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = .black
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		label.accessibilityIdentifier = "productDetailDescription"
		return label
	}()

	/// Add to cart UIButton
	internal lazy var addToCartButton: UIButton = {
		let button = UIButton(type: .roundedRect)
		button.setTitle("Add to cart", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
		button.backgroundColor = .targetBullseyeRedColor
		button.setTitleColor(.white, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		button.accessibilityIdentifier = "productDetailCartButton"
		return button
	}()

	/// Add to list UIButton
	internal lazy var addToListButton: UIButton = {
		let button = UIButton(type: .roundedRect)
		button.setTitle("Add to list", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
		button.backgroundColor = .targetStrokeGrayColor
		button.setTitleColor(.targetNeutralGrayColor, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		button.accessibilityIdentifier = "productDetailListButton"
		return button
	}()

	/// container stack view for all UI elements
	internal lazy var containerStackView: UIStackView = {
		let stack: UIStackView = UIStackView()
		stack.distribution = .fill
		stack.alignment = .fill
		stack.axis = .vertical
		stack.spacing = 16
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.accessibilityIdentifier = "productDetailContainerStack"
		return stack
	}()

	/// Scroll view for content on details page
	internal lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.accessibilityIdentifier = "productDetailScroll"
		return scrollView
	}()

	/// content view for the scroll view
	internal lazy var contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.accessibilityIdentifier = "productDetailContentView"
		return view
	}()

	// MARK: Initializer
	init() {
		super.init(frame: .zero)
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Setup
	/// sets up views by adding subviews
	func setupView() {
		self.backgroundColor = .white
		scrollView.backgroundColor = .white
		addSubview(scrollView)

		scrollView.addSubview(contentView)
		contentView.addSubview(containerStackView)

		containerStackView.addArrangedSubview(titleLabel)
		containerStackView.addArrangedSubview(productImageView)

		pricesStackView.addArrangedSubview(salePriceLabel)
		pricesStackView.addArrangedSubview(originalPriceLabel)

		containerStackView.addArrangedSubview(pricesStackView)
		containerStackView.addArrangedSubview(descriptionLabel)
		containerStackView.addArrangedSubview(addToCartButton)
		containerStackView.addArrangedSubview(addToListButton)

		scrollView.addSubview(containerStackView)
		scrollView.flashScrollIndicators()
	}

	/// sets up constraints for views added
	func setupConstraints() {
		/// scroll view
		scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

		/// content view
		contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

		/// container view
		containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
		containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
		containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
		containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true

	}

	/// Sets font based on what viewState asks to set
	func setPriceLabelFont(font: UIFont) {
		originalPriceLabel.font = font
	}
}
