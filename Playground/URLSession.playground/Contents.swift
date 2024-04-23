import Foundation
import PlaygroundSupport // import 뒤에오는 것은 '라이브러리'
import UIKit


//PlaygroundPage -> PlaygroundSupport에서 제공
PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

let urlString = "https://imgs.xkcd.com/comics/api.png"
let url = URL(string: urlString)! // 받는사람 주소
let request = URLRequest(url: url) // 편지봉투

//completionHandler -> 클로저
let task = session.dataTask(with: request, completionHandler:  { (data, response, error) in
    guard let imageData = data else {
        return
    }
    _ = UIImage(data: imageData)
})

task.resume()
