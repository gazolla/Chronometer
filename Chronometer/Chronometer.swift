//
//  Chronometer.swift
//  Chronometer
//
//  Created by Gazolla on 20/01/17.
//  Copyright © 2017 Gazolla. All rights reserved.
//

import Foundation

struct Time:CustomStringConvertible {
    let minutes:UInt8
    let seconds:UInt8
    let fraction:UInt8
    
    var description: String {
        // add the leading zero for minutes, seconds and millseconds and store them as string constants
        let m  = minutes > 9 ? String(minutes):"0" + String(minutes)
        let s  = seconds > 9 ? String(seconds):"0" + String(seconds)
        let f = fraction > 9 ? String(fraction):"0" + String(fraction)
        return "\(m):\(s):\(f)"
    }
}

class Chronometer {
    
    var isRunning = false
    var timer = Timer()
    var startTime = TimeInterval()
    var update:((_ time:Time)->())?
    
    func start(){
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector:#selector(self.updateTime), userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
            isRunning = true
        }
    }
    
    func stop() {
        timer.invalidate()
        isRunning = false
    }
    
    @objc func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        // Find the difference between current time and strart time
        var elapsedTime: TimeInterval = currentTime - startTime
        
        // calculate the minutes in elapsed time
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        // calculate the seconds in elapsed time
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        // find out the fraction of millisends to be displayed
        let fraction = UInt8(elapsedTime * 100)
        
        let time = Time(minutes: minutes, seconds: seconds, fraction: fraction)
        self.update?(time)
    }
    
}
