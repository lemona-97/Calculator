//
//  ContentView.swift
//  Calculator
//
//  Created by wooseob on 11/28/23.
//

import SwiftUI

enum ButtonType : String {
    case first, second, thrid, fourth, fifth, sixth, seventh, eighth, nineth, zero
    case dot, equal, plus, minus, multiple, devide
    case percent, opposite, clear
    
    var buttonDisplayName: String {
        switch self {
        case .first:
            return "1"
        case .second:
            return "2"
        case .thrid:
            return "3"
        case .fourth:
            return "4"
        case .fifth:
            return "5"
        case .sixth:
            return "6"
        case .seventh:
            return "7"
        case .eighth:
            return "8"
        case .nineth:
            return "9"
        case .zero:
            return "0"
        case .dot:
            return "."
        case .equal:
            return "="
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiple:
            return "X"
        case .devide:
            return "/"
        case .percent:
            return "%"
        case .opposite:
            return "+/-"
        case .clear:
            return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
            
        case .first, .second, .thrid, .fourth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot:
            return .numberButton
        case .equal, .plus, .minus, .multiple, .devide:
            return .orange
        case .percent, .opposite, .clear:
            return .gray
        }
    }
    
    var foregroundColor: Color {
        switch self {
            
        case .first, .second, .thrid, .fourth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot, .equal, .plus, .minus, .multiple, .devide:
            return .white
        case .percent, .opposite, .clear:
            return .black
        }
    }
}
struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    private let buttonData: [[ButtonType]] = [[.clear, .opposite, .percent, .devide],
                                              [.seventh, .eighth, .nineth, .multiple],
                                              [.fourth, .fifth, .sixth, .minus],
                                              [.first, .second, .thrid, .plus],
                                              [.zero, .dot, .equal]]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text(totalNumber)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundStyle(.white)
                }
                ForEach(buttonData, id: \.self) { line in
                    HStack {
                        ForEach(line, id: \.self) { item in
                            Button {
                                if totalNumber == "0" {
                                    if item == .clear {
                                        totalNumber = "0"
                                    } else if item == .plus ||
                                              item == .minus ||
                                              item == .multiple ||
                                              item == .devide {
                                        totalNumber = "Error"
                                    } else {
                                        totalNumber = item.buttonDisplayName
                                    }
                                } else {
                                    if item == .clear {
                                        totalNumber = "0"
                                    } else if item == .plus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .plus
                                        totalNumber = "0"
                                    } else if item == .multiple {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .multiple
                                        totalNumber = "0"
                                    } else if item == .minus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .minus
                                        totalNumber = "0"
                                    } else if item == .devide {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .devide
                                        totalNumber = "0"
                                    } else if item == .opposite {
                                        totalNumber = String((-(Int(totalNumber) ?? 0) ))
                                    } else if item == .equal {
                                        if operatorType == .plus {
                                            totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                                        } else if operatorType == .multiple {
                                            totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                                        } else if operatorType == .minus {
                                            totalNumber = String(tempNumber - (Int(totalNumber) ?? 0))
                                        }  else if operatorType == .devide {
                                            totalNumber = String(tempNumber / (Int(totalNumber) ?? 0))
                                        }
                                        
                                    } else {
                                        totalNumber += item.buttonDisplayName
                                    }
                                }
                                
                            } label: {
                                Text(item.buttonDisplayName)
                                    .frame(width: item == .some(.zero) ? 160 : 80, height: 80)
                                    .background(item.backgroundColor)
                                    .clipShape(Capsule())
                                    .foregroundStyle(item.foregroundColor)
                                    .font(.system(size: 33))
                            }
                        }
                    }

                }
                                
            }
        }
    }
    
}

#Preview {
    ContentView()
}
