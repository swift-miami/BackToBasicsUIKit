import UIKit

class GioViewController: UIViewController {
    
    // MARK: - Variables
    let segmentedControlItems = ["Ada Lovelace", "Nikola Tesla", "Michael Scott"]
    
    let quotes = ["The intellectual, the moral, the religious seem to me all naturally bound up and interlinked together in one great and harmonious whole.",
                  "What one man calls God, another calls the laws of physics.",
                  "Sometimes I'll start a sentence and I don't even know where it's going. I just hope I find it along the way.",
                  "CHINA!"]
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: segmentedControlItems)
        
        /* uncomment 17-28 */
//        let font = UIFont(name: "Verdana", size: UIFont.systemFontSize)!
//        segmentedControl.setTitleTextAttributes([
//            NSAttributedString.Key.font: font,
//            NSAttributedString.Key.foregroundColor: UIColor.lightGray
//            ], for: .normal)
//
//        segmentedControl.setTitleTextAttributes([
//            NSAttributedString.Key.font : font,
//            NSAttributedString.Key.foregroundColor: UIColor.darkGray
//            ], for: .selected)
//
//        segmentedControl.tintColor = .clear

        //segmentedControl.backgroundColor = .gray
        
        //segmentedControl.insertSegment(withTitle: "Donald Trump", at: segmentedControl.numberOfSegments + 1, animated: true)
        //segmentedControl.setTitle(String(segmentedControlItems[0].reversed()), forSegmentAt: 0) /* segment must already exist */
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var darkThemeSwitch : UISwitch = {
       let darkThemeSwitch = UISwitch()
        darkThemeSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        darkThemeSwitch.onTintColor = .black // when isOn = true
        //darkThemeSwitch.tintColor = .gray // when isOn = false
        //darkThemeSwitch.setOn(true, animated: true) // to set switch to On programmatically
        return darkThemeSwitch
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        textLabel.text = quotes[0]
        return textLabel
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Setup
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: darkThemeSwitch)
        
        view.addSubview(segmentedControl)
        view.addSubview(textLabel)
        
        let inset: CGFloat = 16
        view.addConstraints([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            segmentedControl.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: inset),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset)
            ])
    }
    
    //MARK: - UIEvent Actions
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        textLabel.text = quotes[segmentedControl.selectedSegmentIndex]
    }
    
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        animateDarkTheme(enabled: sender.isOn)
    }
    
    // MARK: - Functions
    func animateDarkTheme(enabled isOn: Bool) {
        if isOn {
            self.darkThemeSwitch.thumbTintColor = .lightGray
            
            UIView.animate(withDuration: 0.3) {
                self.view.backgroundColor = .black
                self.textLabel.textColor = .lightGray
                self.segmentedControl.tintColor = .lightGray
            }
            
        } else {
            self.darkThemeSwitch.thumbTintColor = UISwitch().thumbTintColor
    
            UIView.animate(withDuration: 0.3) {
                self.view.backgroundColor = .white
                self.textLabel.textColor = .black
                self.segmentedControl.tintColor = self.view.tintColor
                self.darkThemeSwitch.tintColor = UISwitch().tintColor
            }
        }
    }
}
