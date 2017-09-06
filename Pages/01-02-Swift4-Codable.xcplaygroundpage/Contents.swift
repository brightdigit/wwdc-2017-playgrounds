//: [Previous](@previous)

import Foundation
import PlaygroundSupport

public struct Meetup : Codable {
  public let time:Date
  public let name:String
  public let description:String
  public let link:URL
}

let url = URL(string: "https://api.meetup.com/Lansing-CocoaHeads/events")!

let session = URLSession(configuration: .default)
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .millisecondsSince1970

let task = session.dataTask(with: url) { (data, _, error) in
  let object = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
  let meetups = try! decoder.decode([Meetup].self, from: data!)
  PlaygroundPage.current.finishExecution()
}

task.resume()

PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
