import UIKit

struct Color {
    let red: Float
    let green: Float
    let blue: Float
    let alpha: Float = 1.0
    
    var displayColor: UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}

struct Bar {
    var value: Float
    var color: Color
}

class BarView: UIView {
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .red
    }
}

class BarChart: UIView {
    private var barViews: [BarView] = []
    private var maxValue: Float = 0
    
    var interBarMargin: CGFloat = 5
    
    var bars: [Bar] = [] {
        didSet {
            self.barViews.forEach { $0.removeFromSuperview() }
            
            var barViews = [BarView]()
            
            let barCount = CGFloat(bars.count)
            
            // Calculate the max value before calculating size
            for bar in bars {
                maxValue = max(maxValue, bar.value)
            }
            
            var xOrigin: CGFloat = interBarMargin

            let margins = interBarMargin * (barCount+1)
            let width = (frame.width - margins) / barCount
            
            for bar in bars {

                let height = barHeight(forValue: bar.value)
                let rect = CGRect(x: xOrigin,
                                  y: bounds.height - height,
                                  width: width,
                                  height: height)
                let view = BarView(frame: rect,
                                   color: bar.color.displayColor)
                barViews.append(view)
                addSubview(view)
                
                xOrigin = view.frame.maxX + interBarMargin
            }
            self.barViews = barViews
        }
    }
    
    private func barHeight(forValue value: Float) -> CGFloat {
        return (frame.size.height / CGFloat(maxValue)) * CGFloat(value)
    }
}


let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
barView.backgroundColor = .yellow
let bar1 = Bar(value: 20, color: Color(red: 1, green: 0, blue: 0))
let bar2 = Bar(value: 40, color: Color(red: 0, green: 1, blue: 0))
let bar3 = Bar(value: 25, color: Color(red: 0, green: 0, blue: 1))
barView.bars = [bar1, bar2, bar3]


struct PersonName {
    let givenName: String
    let middleName: String
    var familyName: String
    
    func fullName() -> String {
        return "\(givenName) \(middleName) \(familyName)"
    }
    
    mutating func change(familyName: String) {
        self.familyName = familyName
    }
}

class Person {
    let birthName: PersonName
    var currentName: PersonName
    var countryOfResidence: String
    
    init(name: PersonName, countryOfResidence: String = "UK") {
        birthName = name
        currentName = name
        self.countryOfResidence = countryOfResidence
    }
    
    var displayString: String {
        return "\(currentName.fullName()) - Location: \(countryOfResidence)"
    }
}


//아무것도 넣지않고 아무것도 반환하지 않는 함수
//변수처럼 지정했지만 함수이다.
var printAuthorsDetails: () -> Void = {
        let name = PersonName(givenName: "Keith", middleName: "David", familyName: "Moon")
        let author = Person(name: name)
        print(author.displayString)
}

printAuthorsDetails()


//아무것도 넣지않았지만 무언갈(Person) 반환하는 함수
//무언갈 반환하여 createAuthor에 넣기 때문에 '='가 들어감??
let createAuthor: () -> Person = {
        let name = PersonName(givenName: "Keith", middleName: "David", familyName: "Moon")
        let author = Person(name: name)
        return author
}
let author = createAuthor()
print(author.displayString)


//무언갈 넣었지만 아무것도 반환하지 않는 함수
//무언갈 넣을 때는 해당 프로퍼티에 맞게 클로저에 인자를 생성해준다.
//(String, String, String) -> given, middle, fmaily
let printPersonDetails: (String, String, String) -> Void = { given, middle, family in
//        let
}
