//
//  ViewController.swift
//  FilterImageScaling
//
//  Created by Don Mag on 3/3/21.
//

import UIKit

class ViewController: UIViewController {

	let stackView: UIStackView = {
		let v = UIStackView()
		v.axis = .vertical
		v.spacing = 8
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	
	var imgViews: [UIImageView] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let img = UIImage(named: "p160x160") else {
			fatalError("Could not load image!!!!")
		}

		for _ in 1...3 {
			let v = UIImageView()
			v.contentMode = .center
			v.backgroundColor = .systemTeal
			v.clipsToBounds = true
			stackView.addArrangedSubview(v)
			v.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
			v.heightAnchor.constraint(equalTo: v.widthAnchor).isActive = true
			imgViews.append(v)
		}
		
		view.addSubview(stackView)

		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 8.0),
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		])

		let dim: CGFloat = 0.5
		
		if let scaledImage = imageCIScale(img, dimension: dim, outputScale: 1.0) {
			
			print("original image size:", img.size)
			print("scaled x 2.0 with 1.0 scale:", scaledImage.size)
			
			imgViews[0].image = scaledImage
			
		}
		
		if let scaledImage = imageCIScale(img, dimension: dim, outputScale: UIScreen.main.scale) {
			
			print("original image size:", img.size)
			print("scaled x 2.0 with Screen scale:", scaledImage.size)
			
			imgViews[1].image = scaledImage
			
		}
		
		if let scaledImage = imageCIScale(img, dimension: dim, outputScale: img.scale) {
			
			print("original image size:", img.size)
			print("scaled x 2.0 with Screen scale:", scaledImage.size)
			
			imgViews[2].image = scaledImage
			
		}
		
	}
	
	func imageCIScale(_ image: UIImage, dimension: CGFloat, outputScale: CGFloat) -> UIImage? {
		
		guard let ciImage = CIImage(image: image) else {
			print("no ciImage")
			return nil
		}
		guard let scaleFilter = CIFilter(name: "CILanczosScaleTransform") else {
			print("no filter")
			return nil
		}
		
		scaleFilter.setValue(ciImage, forKey: kCIInputImageKey)
		
		scaleFilter.setValue(ciImage, forKey: kCIInputImageKey)
		scaleFilter.setValue(dimension, forKey: kCIInputScaleKey)
		scaleFilter.setValue(1.0, forKey: kCIInputAspectRatioKey)
		
		guard let outputImage = scaleFilter.outputImage else { return nil }
		
		let uiImage = UIImage(ciImage: outputImage, scale: outputScale, orientation: image.imageOrientation)
		
		return uiImage
		
	}

}

