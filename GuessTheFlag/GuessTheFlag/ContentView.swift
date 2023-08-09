//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matsvei Liapich on 3/9/23.
//

import SwiftUI

struct FlagImage: View {
    var flagName: String
    var body: some View {
        Image(flagName)
            .resizable()
            .frame(width: 200, height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .scaledToFit()
            .shadow(color: Color("Gunmetal"), radius: 25)
    }
}

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .foregroundColor(Color("Powder Blue"))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded, weight: .bold))
    }
}

struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("French Grey"))
            .font(.headline.weight(.bold))
    }
}

extension View {
    func largeTitleStyle() -> some View {
        modifier(LargeTitle())
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

extension View {
    func subtitleStyle() -> some View {
        modifier(Subtitle())
    }
}

struct ContentView: View {
    @State private var wrongFlag = false
    @State private var gameOver = false
    @State private var correctFlag = ""
    @State private var buttonMessage = ""
    @State private var countries = ["af", "ax", "al", "dz", "as", "ad", "ao", "ai", "aq", "ag", "ar", "am", "aw", "au", "at", "az", "bs", "bh", "bd", "bb", "by", "be", "bz", "bj", "bm", "bt", "bo", "ba", "bw", "bv", "br", "io", "bn", "bg", "bf", "bi", "kh", "cm", "ca", "cv", "ky", "cf", "td", "cl", "cn", "cx", "cc", "co", "km", "cg", "cd", "ck", "cr", "ci", "hr", "cu", "cy", "cz", "dk", "dj", "dm", "do", "ec", "eg", "sv", "gq", "er", "ee", "et", "fk", "fo", "fj", "fi", "fr", "gf", "pf", "tf", "ga", "gm", "ge", "de", "gh", "gi", "gr", "gl", "gd", "gp", "gu", "gt", "gg", "gn", "gw", "gy", "ht", "hm", "va", "hn", "hk", "hu", "is", "in", "id", "ir", "iq", "ie", "im", "il", "it", "jm", "jp", "je", "jo", "kz", "ke", "ki", "kp", "kr", "kw", "kg", "la", "lv", "lb", "ls", "lr", "ly", "li", "lt", "lu", "mo", "mk", "mg", "mw", "my", "mv", "ml", "mt", "mh", "mq", "mr", "mu", "yt", "mx", "fm", "md", "mc", "mn", "me", "ms", "ma", "mz", "mm", "na", "nr", "np", "nl", "an", "nc", "nz", "ni", "ne", "ng", "nu", "nf", "mp", "no", "om", "pk", "pw", "ps", "pa", "pg", "py", "pe", "ph", "pn", "pl", "pt", "pr", "qa", "re", "ro", "ru", "rw", "sh", "kn", "lc", "pm", "vc", "ws", "sm", "st", "sa", "sn", "rs", "sc", "sl", "sg", "sk", "si", "sb", "so", "za", "gs", "es", "lk", "sd", "sr", "sj", "sz", "se", "ch", "sy", "tw", "tj", "tz", "th", "tl", "tg", "tk", "to", "tt", "tn", "tr", "tm", "tc", "tv", "ug", "ua", "ae", "gb", "us", "um", "uy", "uz", "vu", "ve", "vn", "vg", "vi", "wf", "eh", "ye", "zm", "zw"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var question = 0
    @State private var selectedFlag: Int? = nil

    var body: some View {
        ZStack {
            Color("Gunmetal")
                .ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                
                Text("Guess The Flag")
                    .largeTitleStyle()
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the Flag Of")
                            .subtitleStyle()
                        Text(getCorrectCountryName(countryCode: countries[correctAnswer]))
                            .titleStyle()
                    }
                    
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagTapped(number)
                            correctAnswer == number ? correctFeedback() : wrongFeedback()
                            withAnimation(.easeOut(duration: 0.3)) {
                                selectedFlag = number
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    selectedFlag = nil
                                }
                            }
                        }) {
                            FlagImage(flagName: countries[number])
                                .scaleEffect(selectedFlag == number ? 1.2 : 1.0)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                Spacer()
                
                Text("Score: \(score) of \(question)")
                    .largeTitleStyle()
                

                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert("Wrong Answer", isPresented: $wrongFlag) {
            Button("Continue", action: shuffleFlags)
        } message: {
            Text(correctFlag)
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your final score was \(score).")
        }
        .preferredColorScheme(.dark)
    }
    
    func flagTapped(_ number: Int) {
        if question < 24 {
            if number == correctAnswer {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeIn(duration: 0.3)) {
                        selectedFlag = nil
                    }
                    score += 1
                    question += 1
                    shuffleFlags()
                }
            } else {
                let countryName = getCorrectCountryName(countryCode: countries[number])
                correctFlag = "You selected \(countryName)."
                question += 1
                wrongFlag = true
            }
        } else {
            score += 1
            question += 1
            gameOver = true
        }
    }

    func shuffleFlags() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        shuffleFlags()
        score = 0
        question = 0
    }
    
    func getCorrectCountryName(countryCode: String) -> String {
            let locale = Locale(identifier: "en_US")
            return locale.localizedString(forRegionCode: countryCode.uppercased()) ?? "Unknown"
        }
    
    func correctFeedback() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
    }

    func wrongFeedback() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
