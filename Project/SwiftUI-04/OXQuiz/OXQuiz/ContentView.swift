//
//  ContentView.swift
//  OXQuiz
//
//  Created by Jungman Bae on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    @State var number1: Int = 4
    @State var number2: Int = 2
    @State var resultNumber: Int = 9
    
    @State var countCorrect: Int = 0
    @State var countWrong: Int = 0
    
    var body: some View {
        VStack {
            Text("다음 수식은 맞을까요?")
            Spacer()
            Text("\(number1) x \(number2) = \(resultNumber)")
            Spacer()
            HStack {
                Spacer()
                Button {
                    selectCorrect()
                    reloadGame()
                } label: {
                    HStack {
                        Image(systemName: "checkmark.diamond.fill")
                        Text("맞음")
                            .bold()
                    }
                    .foregroundStyle(.green)
                }
                Spacer()
                Button {
                    selectWrong()
                    reloadGame()
                } label: {
                    HStack {
                        Image(systemName: "xmark.diamond")
                        Text("틀림")
                            .bold()
                    }
                    .foregroundStyle(.red)
                }
                Spacer()
            }
            Spacer()
            HStack {
                Text("\(countCorrect)개 맞춤")
                Text("\(countWrong)개 틀림")
            }
            Spacer()
            Button("카운트 초기화") {
                countCorrect = 0
                countWrong = 0
                reloadGame()
            }
        }
        .font(.largeTitle)
        .padding()
        .onAppear {
            reloadGame()
        }
    }
    
    func reloadGame() {
        print("새로운 게임의 시작")
        number1 = Int.random(in: 1..<10)
        number2 = Int.random(in: 1..<10)
        
        let seedNumber = Int.random(in: 0..<10)
        
        if seedNumber < 8 {
            // 80% 실행 - 정상 결과 (0,1,2,3,4,5,6,7)
            resultNumber = number1 * number2
        } else {
            // 20% - 잘못된 결과 (8,9)
            repeat {
                let realResult = number1 * number2
                resultNumber = Int.random(in: (realResult-3)..<(realResult+3))
            } while resultNumber == number1 * number2
        }
    }
    
    func selectCorrect() {
        if resultNumber == number1 * number2 {
            countCorrect += 1
        } else {
            countWrong += 1
        }
    }
    
    func selectWrong() {
        if resultNumber == number1 * number2 {
            countWrong += 1
        } else {
            countCorrect += 1
        }
    }
}

#Preview {
    ContentView()
}
