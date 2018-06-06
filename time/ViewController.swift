//
//  ViewController.swift
//  time
//
//  Created by Shuji Shimooka on 2018/06/06.
//  Copyright © 2018年 ssforward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer : Timer?
    var count = 0
    
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let setting = UserDefaults.standard
        setting.register(defaults: [settingKey:10])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: AnyObject) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        
        performSegue(withIdentifier: "setting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: AnyObject) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
    @IBAction func stopButtonAction(_ sender: AnyObject) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
    }
    
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timeValue = settings.integer(forKey: settingKey)
        let remainCount = timeValue - count
        
        countDownLabel.text = "残り\(remainCount)秒"
        
        return remainCount
    }
    
    @objc func timerInterrupt(_ timer:Timer) {
        count += 1
        
        if displayUpdate() <= 0 {
            count = 0
            timer.invalidate()
            
            let alertController = UIAlertController(title: "end", message: "timer end", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func viewDidApper(_ animated:Bool) {
        count = 0
        _ = displayUpdate()
    }
}

