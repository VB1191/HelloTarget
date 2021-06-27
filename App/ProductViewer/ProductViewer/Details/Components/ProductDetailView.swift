//
//  ProductDetailView.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

final class ProductDetailView: UIView, ReusableView {
	static var reuseID: String = "ProductDetailViewIdentifier"

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

	internal lazy var productImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.accessibilityIdentifier = "productDetailImage"
		return imageView
	}()

	internal lazy var salePriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 26.0, weight: .medium)
		label.textColor = .targetBullseyeRedColor
		label.textAlignment = .center
		label.accessibilityIdentifier = "productDeatilSalePrice"
		return label
	}()

	internal lazy var originalPriceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 22.0, weight: .medium)
		label.textColor = .targetNeutralGrayColor
		label.textAlignment = .center
		label.accessibilityIdentifier = "productDetailOriginalPrice"
		return label
	}()

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

	internal lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = .black
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		label.accessibilityIdentifier = "productDetailDescription"
		return label
	}()

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

	internal lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.accessibilityIdentifier = "productDetailScroll"
		return scrollView
	}()

	lazy var contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.accessibilityIdentifier = "productDetailContentView"
		return view
	}()

	init() {
		super.init(frame: .zero)
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

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

	func setPriceLabelFont(font: UIFont) {
		originalPriceLabel.font = font
	}
}
