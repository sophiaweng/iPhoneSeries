//
//  ViewController.swift
//  iPhoneSeries
//
//  Created by 翁淑惠 on 2020/11/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var beforeImage: UIImageView!
    @IBOutlet weak var afterImage: UIImageView!
    @IBOutlet weak var yearDatepicker: UIDatePicker!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var autoSwitch: UISwitch!
    let dateFormatter = DateFormatter()
    var timer: Timer?
    var playIdx: Int = 2006
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "yyyy"
        changeYear(dateFormatter.string(from: sender.date), "datepicker")
    }
    
    @IBAction func changeSlider(_ sender: UISlider) {
        changeYear("\(Int(sender.value))", "slider")
    }
    
    @IBAction func changeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            //start autoplay
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(autoPlay), userInfo: nil, repeats: true)
        } else {
            //stop autoplay
            timer?.invalidate()
        }
    }
    
    @objc func autoPlay() {
        if playIdx > 2019 {
            playIdx = 2006
        }
        playIdx += 1
        changeYear(String(playIdx), "switch")
    }
    
    func changeYear(_ text: String, _ actType: String) {
        //sync DatePicker
        if actType != "datepicker" {
            dateFormatter.dateFormat = "yyyy/MM/dd"
            yearDatepicker.setDate(dateFormatter.date(from: text+"/01/01")!, animated: true)
        }
        //sync Slider
        if actType != "slider" {
            yearSlider.setValue(Float(text)!, animated: true)
        }
        //sync Label
        yearLabel.text = "iPhone " + text
        //sync Image
        afterImage.image = UIImage(named: "iPhone_" + text)
        //record autoplay index
        playIdx = Int(text)!
    }

}

