//
//  ExerciseClockView.swift
//  TheGrow
//
//  Created by Adeel on 07/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit
import MSCircularSlider

class ExerciseClockView: UIView {
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var CircleTimeSlider: MSCircularSlider!
    
    var timer = Timer()
    
    override func draw(_ rect: CGRect) {
        //Drawing code
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
    }
    
    @IBAction func StopBtnAction(_ sender: Any) {
        timer.invalidate()
    }
    
    @objc func tick() {
        let timeDate = DateFormatter.localizedString(from: Date(),
                                                     dateStyle: .medium,
                                                     timeStyle: .medium)
        print(timeDate)
        TimeLabel.text = self.removeDateFromTime(time: timeDate)
    }
    
    func removeDateFromTime(time:String) -> String {
        let removeTime = time.components(separatedBy: " ")
        //let removeAmPm = removeTime[1].components(separatedBy: " ")
        return removeTime[2]
    }
}
