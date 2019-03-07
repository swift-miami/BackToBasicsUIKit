/*
- UISlider
    - How do you customize it
- How do you set minimum and maximum values
- How do you set a value
*/

import UIKit
import AVFoundation

class ProgrammaticSliderViewController: UIViewController {
    
    let slider = UISlider()
    var imageView : UIImageView!
    var songPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSlider()
        setupBackground()
        layoutConstraints()
        }
    
    override func viewDidAppear(_ animated: Bool) {
         playSong()
    }
    
    func setupSlider() {
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(self.changeSliderValue(_:)), for: .valueChanged)
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 1
        slider.maximumTrackTintColor = .black
        slider.thumbTintColor = .blue
        slider.isContinuous = true
    }
    
    func layoutConstraints() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        slider.widthAnchor.constraint(equalToConstant: 250).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func changeSliderValue(_ sender: UISlider) {
        songPlayer?.volume = slider.value
    }
    
    func setupBackground(){
        let background = UIImage(named: "moonLake")
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.insertSubview(imageView, at: 0)
    }
    
    func playSong() {
        guard let url = Bundle.main.url(forResource: "kaiEngelMoonlight", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            songPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let songPlayer = songPlayer else { return }
            songPlayer.play()
        } catch _ {
            return
        }
    }
}


