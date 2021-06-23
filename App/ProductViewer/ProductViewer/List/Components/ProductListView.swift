//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

//final class ProductListView: UIView {
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var productImage: UIImageView!
//}
//
//extension ProductListView: ReusableNib {
//    @nonobjc static let nibName = "ProductListView"
//    @nonobjc static let reuseID = "ProductListViewIdentifier"
//
//    @nonobjc func prepareForReuse() {
//
//    }
//}

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
		return label
	}()

	internal lazy var line: UIView = {
		let lineView: UIView = UIView()
		lineView.backgroundColor = UIColor.gray
		return lineView
	}()

	internal lazy var priceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	internal lazy var productImage: UIImageView = {
		let imageView: UIImageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	init() {
		super.init(frame: .zero)
		accessibilityIdentifier = "ProductListView"
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

		rightStackView.addArrangedSubview(titleLabel)
		rightStackView.addArrangedSubview(line)
		rightStackView.addArrangedSubview(priceLabel)
		addSubview(rightStackView)

	}

	func setupConstraints() {
		productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
		productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
		productImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
		productImage.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
		productImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true

		line.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

		rightStackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 16).isActive = true
		rightStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
		rightStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
		rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
	}
}
