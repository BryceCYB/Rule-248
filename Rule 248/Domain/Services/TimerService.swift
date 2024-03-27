//
//  TimerService.swift
//  Rule 248
//
//  Created by Bryce Chan on 8/11/2023.
//

import Foundation

final class TimerService {
    
    var timer: Timer?

    var startTime: String?
    
    var endTime: String?

    var totalTime: String?
    
    var secondPassed = 0
    
    var isStarted: Bool = false
        
    let formatter = DateFormatter()
    
    static let shared = TimerService()
    
    private init(){
        formatter.dateFormat = "HH:mm:ss"
    }
    
    func getStartTime() {
        if isStarted { return }
        
        let date = Date()
        startTime = formatter.string(from: date)
        isStarted = true
        
        startTimer()
    }
    
    func getEndTime() {
        let date = Date()
        endTime = formatter.string(from: date)
        isStarted = true
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(trackTotalTime), userInfo: nil, repeats: true)

    }

    func stopTimer() {
        guard self.timer != nil else {
            fatalError("No active timer.")
        }
        timer?.invalidate()
        getEndTime()
    }
    
    @objc func trackTotalTime(sender: AnyObject?) {
        secondPassed += 1
        convertSecondsToFormattedTime(seconds: secondPassed)
    }
    
    private func convertSecondsToFormattedTime(seconds: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        
        if seconds > 3600 {
            totalTime = "\(hours):\(minutes):\(seconds)"
        } else if seconds > 60 {
            totalTime = "\(minutes):\(seconds)"
        } else {
            totalTime = "\(seconds)s"
        }
    }
    
}
