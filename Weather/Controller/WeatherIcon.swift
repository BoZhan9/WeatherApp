//
//  WeatherIcon.swift
//  Weather
//
//  Created by Brian Zhang on 10/29/21.
//

import Foundation
import UIKit

func isDay() -> Bool {
    let hour = Calendar.current.component(.hour, from: Date())
    
    if hour >= 6 && hour <= 18 {
        return true
    }
    return false
}

let dayIcons : [String: UIImage] = [
    "Sunny": UIImage(named: "01-s")!,
    "Mostly sunny": UIImage(named: "02-s")!,
    "Partly sunny": UIImage(named: "03-s")!,
    "Intermittent clouds": UIImage(named: "04-s")!,
    "Hazy sunshine": UIImage(named: "05-s")!,
    "Mostly cloudy": UIImage(named: "06-s")!,
    "Cloudy": UIImage(named: "07-s")!,
    "Dreary (overcast)": UIImage(named: "08-s")!,
    "Fog": UIImage(named: "11-s")!,
    "Showers": UIImage(named: "12-s")!,
    "Mostly cloudy w/ showers": UIImage(named: "13-s")!,
    "Partly sunny w/ showers": UIImage(named: "14-s")!,
    "T-Storms": UIImage(named: "15-s")!,
    "Mostly cloudy w/ t-Storms": UIImage(named: "16-s")!,
    "Partly sunny w/ t-Storms": UIImage(named: "17-s")!,
    "Rain": UIImage(named: "18-s")!,
    "Flurries": UIImage(named: "19-s")!,
    "Mostly cloudy w/ flurries": UIImage(named: "20-s")!,
    "Partly sunny w/ flurries": UIImage(named: "21-s")!,
    "Snow": UIImage(named: "22-s")!,
    "Mostly cloudy w/ snow": UIImage(named: "23-s")!,
    "Ice": UIImage(named: "24-s")!,
    "Sleet": UIImage(named: "25-s")!,
    "Freezing rain": UIImage(named: "26-s")!,
    "Rain and snow": UIImage(named: "29-s")!,
    "Hot": UIImage(named: "30-s")!,
    "Cold": UIImage(named: "31-s")!,
]

let nightIcons : [String: UIImage] = [
    "Cloudy": UIImage(named: "07-s")!,
    "Dreary (overcast)": UIImage(named: "08-s")!,
    "Fog": UIImage(named: "11-s")!,
    "Showers": UIImage(named: "12-s")!,
    "T-Storms": UIImage(named: "15-s")!,
    "Rain": UIImage(named: "18-s")!,
    "Flurries": UIImage(named: "19-s")!,
    "Snow": UIImage(named: "22-s")!,
    "Ice": UIImage(named: "24-s")!,
    "Sleet": UIImage(named: "25-s")!,
    "Freezing rain": UIImage(named: "26-s")!,
    "Rain and snow": UIImage(named: "29-s")!,
    "Hot": UIImage(named: "30-s")!,
    "Cold": UIImage(named: "31-s")!,
    "Windy": UIImage(named: "32-s")!,
    "Clear": UIImage(named: "33-s")!,
    "Mostly clear": UIImage(named: "34-s")!,
    "Partly cloudy": UIImage(named: "35-s")!,
    "Intermittent clouds": UIImage(named: "36-s")!,
    "Hazy moonlight": UIImage(named: "37-s")!,
    "Mostly cloudy": UIImage(named: "38-s")!,
    "Partly cloudy w/ showers": UIImage(named: "39-s")!,
    "Mostly cloudy w/ showers": UIImage(named: "40-s")!,
    "Partly cloudy w/ t-Storms": UIImage(named: "41-s")!,
    "Mostly cloudy w/ T-Storms": UIImage(named: "42-s")!,
    "Mostly cloudy w/ flurries": UIImage(named: "43-s")!,
    "Mostly cloudy w/ snow": UIImage(named: "43-s")!
]

