import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

public func customerSays(_ message: String) {
    print("[Customer] \(message)")
}

public func sandwichMakerSays(_ message: String, waitFor time: UInt32 = 0) {
    print("[Sandwich maker] \(message)")
    if time > 0 {
        print("                 ... this will take \(time)s")
        sleep(time)
    }
}

func toastBread(_ bread: String,
                completion: @escaping (String) -> Void)
{
    DispatchQueue.global().async {
        sandwichMakerSays("Toasting the bread... Standing by...", waitFor: 5)
        completion("Crispy \(bread)")
    }
}

func slice(_ ingredients: [String],
        completion: @escaping ([String]) -> Void)
{
    DispatchQueue.global().async {
        let result = ingredients.map { ingredient in
            sandwichMakerSays("Slicing \(ingredient)", waitFor: 1)
            return "sliced \(ingredient)"
        }
        completion(result)
    }
}

func makeSandwich(bread: String, ingredients: [String], condiments: [String],
                  completion: @escaping (String) -> Void) {
  sandwichMakerSays("Preparing your sandwich...")

  // 요리사에게 빵을 구우라고 시킴!
  toastBread(bread) { toasted in
    // 요리사가 빵을 굽고 이 다음에는 무얼할지 물어보러 옴! (이때 빵을 굽고 completion에 담긴 것을 가져옴)
    // '(completion을 가져오며)빵 다 구웠는데 뭐하면 될까요?' -> '썰어!'
    slice(ingredients) { sliced in
      sandwichMakerSays("Spreading \(condiments.joined(separator: ", and ")) om \(toasted)")
      sandwichMakerSays("Layering \(sliced.joined(separator: ", "))")
      sandwichMakerSays("Putting lettuce on top")
      sandwichMakerSays("Putting another slice of bread on top")
      
      completion("\(ingredients.joined(separator: ", ")), \(condiments.joined(separator: ", ")) on \(toasted)")
    }
  }
}

sandwichMakerSays("Hello to Cafe Complete, where we handle your order with care.")
sandwichMakerSays("Please place your order.")

let clock = ContinuousClock()
let start = clock.now
makeSandwich(bread: "Rye", ingredients: ["Cucumbers", "Tomatoes"], condiments: ["Mayo", "Mustard"]) { sandwich in
  customerSays("Hmmm.... this looks like a delicious \(sandwich) sandwich!")
  
  let time = clock.now - start
  print("Making this sandwich took \(time)")
}

print("The end.")
