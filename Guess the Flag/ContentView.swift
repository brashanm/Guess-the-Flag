//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Brashan Mohanakumar on 2023-10-18.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    var body: some View {
        Image(country)
            .clipShape(.rect)
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questions = 0
    @State private var gameOver = false
    var gameOverString = "Game Over"
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag!")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                Spacer()
                VStack(spacing: 15) {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.bold))
                    
                    ForEach(0..<3 ) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                                .clipShape(.rect)
                                .shadow(radius: 5)
                        }
                    }
                }
                Spacer()
                Spacer()
                Text("Score is \(score)")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(gameOverString, isPresented: $gameOver) {
            Button("Continue", action: resetGame)
        } message: {
            Text("GAME OVER")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        }
        else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
        }
        showingScore = true
        questions = questions + 1
        if questions == 8 {
            gameOver = true
        }
    }
    
    func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        questions = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
//
//#Preview {
//    ContentView()
//}
