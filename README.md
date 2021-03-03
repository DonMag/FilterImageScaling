# FilterImageScaling

Exploring different results from CIImage Output scale when using CIFilter / CILanczosScaleTransform to scale images.

		let uiImage = UIImage(ciImage: outputImage, scale: 1.0, orientation: inputImage.imageOrientation)

vs

		let uiImage = UIImage(ciImage: outputImage, scale: UIScreen.main.scale, orientation: inputImage.imageOrientation)

vs

		let uiImage = UIImage(ciImage: outputImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)

Also compares using a Universal scale vs a multi-resolution (@1x / @2x / @3x) image resource.
