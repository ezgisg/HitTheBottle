//
//  ViewController.swift
//  hitTheBottle
//
//  Created by Ezgi Sümer Günaydın on 13.03.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

 
    
    var bottleDistance = Float()
    var bottleSize = Double()
    let bottleDistanceSlider = UISlider()
    let bottleSizeSlider = UISlider()
    let ballSpeedSlider = UISlider()
    let ballAngleSlider = UISlider()
    var nameTextField = UITextField()
    var gamerName = ""
    var counter = 0
    var counterLabel = UILabel()
    var bottleDistanceLabel = UILabel()
    var bottleSizeLabel = UILabel()
    var ballSpeedLabel = UILabel()
    var ballAngleLabel = UILabel()
    var bottleImageView = UIImageView()
    var ballImageView = UIImageView()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let initialY = 150
    let playButton = UIButton(type: .custom)
    var bottlePosition = true
    var range : Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let bootleImage = UIImage(named: "bottle")
        bottleImageView = UIImageView(image: bootleImage)
        let bootleFrame = CGRect(x: 100 , y: initialY , width: 80 , height: 80)
//        let angleInDegress: CGFloat = 90
//        let angleInRadians = angleInDegress * .pi / 180
//        bootleImageView.transform = CGAffineTransform(rotationAngle: angleInRadians)
        bottleImageView.frame = bootleFrame
        view.addSubview(bottleImageView)
        
        bottleDistanceSlider.value =   bottleDistanceSlider.minimumValue
        bottleDistanceLabel.text = "Bottle Distance: \(Int(bottleDistanceSlider.value))"
        bottleSizeSlider.value = bottleSizeSlider.minimumValue
        bottleSize = Double(bottleSizeSlider.value)
        let bottleSizeString = String(format: "%.2f", bottleSize)
        bottleSizeLabel.text = "Bottle Size: \(bottleSizeString)"
        ballSpeedSlider.value = ballSpeedSlider.minimumValue
        ballSpeedLabel.text = "Ball Speed: \(Int(ballSpeedSlider.value))"
        ballAngleSlider.value = ballAngleSlider.minimumValue
        ballAngleLabel.text = "Ball Angle: \(Int(ballAngleSlider.value))"
        
        let ballImage = UIImage(named: "football")
        ballImageView = UIImageView(image: ballImage)
        ballImageView.frame = CGRect(x: 30, y: initialY + 40, width: 40, height: 40)
        let angleInDegress: CGFloat = 45
        let angleInRadians = angleInDegress * .pi / 180
        ballImageView.transform = CGAffineTransform(rotationAngle: angleInRadians)
        view.addSubview(ballImageView)
        
//        bottleDistanceLabel.text = "Bottle Distance:"
        bottleDistanceLabel.frame = CGRect(x: 10 , y: initialY + 100, width: 200, height: 20)
        view.addSubview(bottleDistanceLabel)
        
        bottleDistanceSlider.minimumValue = 100
        bottleDistanceSlider.maximumValue = 1500
        bottleDistanceSlider.addTarget(self, action: #selector(bottleDistanceSliderValueChanges), for: .valueChanged)
        bottleDistanceSlider.frame = CGRect(x: 10, y: initialY + 130 , width: Int(width) - 20 , height: 20)
        view.addSubview(bottleDistanceSlider)
        
//        bottleSizeLabel.text = "Bottle Size:"
        bottleSizeLabel.frame = CGRect(x: 10, y: initialY + 160 , width: 200, height: 20)
        view.addSubview(bottleSizeLabel)
        
        bottleSizeSlider.minimumValue = 0.1
        bottleSizeSlider.maximumValue = 1
        bottleSizeSlider.addTarget(self, action: #selector(bottleSizeSliderValueChanges), for: .valueChanged)
        bottleSizeSlider.frame = CGRect(x: 10, y: initialY + 190, width: Int(width) - 20 , height: 20)
        view.addSubview(bottleSizeSlider)
        
        
//        ballSpeedLabel.text = "Ball Speed:"
        ballSpeedLabel.frame = CGRect(x: 10, y: initialY + 220 , width: 200, height: 20)
        view.addSubview(ballSpeedLabel)
        
        ballSpeedSlider.minimumValue = 0
        ballSpeedSlider.maximumValue = 100
        ballSpeedSlider.frame = CGRect(x: 10, y: initialY + 250, width: Int(width) - 20 , height: 20)
        ballSpeedSlider.addTarget(self, action: #selector(ballSpeedSliderValueChanges), for: .valueChanged)
        view.addSubview(ballSpeedSlider)
        
        
//        ballAngleLabel.text = "Ball Angle:"
        ballAngleLabel.frame = CGRect(x: 10, y: initialY + 280 , width: 200, height: 20)
        view.addSubview(ballAngleLabel)
        
        ballAngleSlider.minimumValue = 0
        ballAngleSlider.maximumValue = 90
        ballAngleSlider.frame = CGRect(x: 10, y: initialY + 310, width: Int(width) - 20 , height: 20)
        ballAngleSlider.addTarget(self, action: #selector(ballAngleSliderValueChanges), for: .valueChanged)
        view.addSubview(ballAngleSlider)
        
        playButton.setTitle("Play", for: .normal)
        playButton.backgroundColor = .blue
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        playButton.layer.cornerRadius = 10
        playButton.frame = CGRect(x: Int(view.center.x) - 50, y: initialY + 350, width: 100, height: 40)
        playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        view.addSubview(playButton)
        playButton.isEnabled = false
        playButton.alpha = 0.2
        
        
        nameTextField.delegate = self
        
        nameTextField.placeholder = "Please enter your name"
        nameTextField.font = UIFont(name: "Arial", size: 16.0)
        nameTextField.textAlignment = .center
        nameTextField.frame = CGRect(x: 20, y:  initialY + 430, width: Int(width) - 40, height: 40)
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 5.0
        nameTextField.addTarget(self, action: #selector(nameTextChanged), for: .allEditingEvents)
        view.addSubview(nameTextField)
        
        counterLabel.text = "Score: \(counter) "
        counterLabel.font = UIFont(name: "Arial", size: 16.0)
        counterLabel.textAlignment = .center
        counterLabel.frame = CGRect(x: 20, y:  initialY + 480, width: Int(width) - 40, height: 40)
        counterLabel.layer.borderColor = UIColor.black.cgColor
        counterLabel.layer.borderWidth = 1.0
        counterLabel.layer.cornerRadius = 5.0
        view.addSubview(counterLabel)
        
      
        
        
    }
    @objc func bottleSizeSliderValueChanges() {
        bottleSize = Double(bottleSizeSlider.value)
        let bottleSizeString = String(format: "%.2f", bottleSize)
        bottleSizeLabel.text = "Bottle Size: \(bottleSizeString)"
        var newFrame = bottleImageView.frame
        newFrame.size.height = 50 + bottleSize * 50
        newFrame.size.width = newFrame.size.height
        newFrame.origin.y = CGFloat(initialY+80) - newFrame.size.height
        bottleImageView.frame = newFrame
    }
    

    @objc func bottleDistanceSliderValueChanges() {
        bottleDistance = bottleDistanceSlider.value
        bottleDistanceLabel.text = "Bottle Distance: \(Int(bottleDistanceSlider.value))"
        let bottleDistanceForView = (width - 200) * (CGFloat(bottleDistance) - 100) / (1500 - 100)
        bottleImageView.transform = CGAffineTransform(translationX: bottleDistanceForView, y: 0)
//        bottleImageView.center.x = 100 + bottleDistanceForView
    
    }
    
    @objc func ballSpeedSliderValueChanges() {
        ballSpeedLabel.text = "Ball Speed: \(Int(ballSpeedSlider.value))"
    
    }
    
    @objc func ballAngleSliderValueChanges() {
        ballAngleLabel.text = "Ball Angle: \(Int(ballAngleSlider.value))"
        let angleInDegress: CGFloat = CGFloat(45 - (Int(ballAngleSlider.value)))
        let angleInRadians = angleInDegress * .pi / 180
        ballImageView.transform = CGAffineTransform(rotationAngle: angleInRadians)
    
    }
    
    
    @objc func playButtonClicked() {
        let delta = bottleSizeSlider.value
        let teta = ballAngleSlider.value
        let speed = ballSpeedSlider.value
        let distance = bottleDistanceSlider.value
        let range = speed * speed * teta.sinDoubleTetaValue() / 10
        print("range: \(range), teta: \(teta), speed: \(speed), distance: \(distance), delta: \(delta)")
       
        if range >= distance - delta * 100 && range <= distance + delta * 100 && bottlePosition == true {
            bottlePosition = false
            let angleInDegress: CGFloat = 90
            let angleInRadians = angleInDegress * .pi / 180
            let rotationTransform = CGAffineTransform(rotationAngle: angleInRadians)
            let translationTransform = CGAffineTransform(translationX: bottleImageView.frame.size.height, y: 0)
            bottleImageView.transform = rotationTransform.concatenating(translationTransform)
            playButton.setTitle("Reset", for: .normal)
            if gamerName == nameTextField.text {
                counter += 1
                counterLabel.text = "Score: \(counter) "
            } else {
                gamerName = nameTextField.text ?? ""
                counter = 1
                counterLabel.text = "Score: \(counter) "
            }
       
        } else if bottlePosition == false {
            bottlePosition = true
            playButton.setTitle("Play", for: .normal)
            let rotationTransform = CGAffineTransform(rotationAngle: 0)
            bottleImageView.transform = rotationTransform
            bottleDistanceSlider.value =   bottleDistanceSlider.minimumValue
            bottleDistanceLabel.text = "Bottle Distance: \(Int(bottleDistanceSlider.value))"
            bottleSizeSlider.value = bottleSizeSlider.minimumValue
            bottleSize = Double(bottleSizeSlider.value)
            let bottleSizeString = String(format: "%.2f", bottleSize)
            bottleSizeLabel.text = "Bottle Size: \(bottleSizeString)"
            ballSpeedSlider.value = ballSpeedSlider.minimumValue
            ballSpeedLabel.text = "Ball Speed: \(Int(ballSpeedSlider.value))"
            ballAngleSlider.value = ballAngleSlider.minimumValue
            ballAngleLabel.text = "Ball Angle: \(Int(ballAngleSlider.value))"
            
            if gamerName != nameTextField.text {
                gamerName = nameTextField.text ?? ""
                counter = 0
                counterLabel.text = "Score: \(counter) "
            }
            
        } else {
            if gamerName != nameTextField.text {
                gamerName = nameTextField.text ?? ""
                counter = 0
                counterLabel.text = "Score: \(counter) "
            }
        }
        
    }
    
    @objc func nameTextChanged (_ textField: UITextField) {
        if let text = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
            playButton.isEnabled = true
            playButton.alpha = 1.0
        } else {
            playButton.isEnabled = false
            playButton.alpha = 0.2
        }
    }

}

extension Float {
    func sinDoubleTetaValue() -> Float {
        let radians = 2 * self * .pi / 180.0
        return (sin(radians))
    }
}

