//
//  ContentView.swift
//  count
//
//  Created by MacBook pro on 2020/9/21.
//  Copyright © 2020 MacBook pro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let arrayf1 = ["C","(",")","/"]
    let arrayf2 = ["7","8","9","X"]
    let arrayf3 = ["4","5","6","-"]
    let arrayf4 = ["1","2","3","+"]
    let arrayf5 = ["0",".","="]
    @State var textfield:String = ""
    @State var outText:String = ""
    
    var body: some View {
        ZStack{
            Color.init(.sRGB, red: 0, green: 1/255.0, blue: 2/255.0, opacity: 1.0).edgesIgnoringSafeArea(.all)
                ZStack{
                    VStack{
                        textView(textfield: $textfield)
                            .frame( height: 200)
                        HStack{
                            Spacer()
                            Text(outText)
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                            .multilineTextAlignment(.center)
                            .padding(.all, 25)
                        }
                            
                        HStack{
                            ForEach(0..<arrayf1.count){ index in
                                ButtonView(text: self.arrayf1[index], width: 75, height: 75,textfield: self.$textfield, outText: self.$outText)
                                    .padding(.init(5.0))
                                }
                        }
                        HStack{
                            ForEach(0..<arrayf2.count){ index in
                                    ButtonView(text: self.arrayf2[index], width: 75, height: 75,  textfield: self.$textfield, outText: self.$outText)
                                    .padding(.init(5.0))
                                }
                        }
                        HStack{
                            ForEach(0..<arrayf3.count){ index in
                                 ButtonView(text: self.arrayf3[index], width: 75, height: 75, textfield: self.$textfield, outText: self.$outText)
                                 .padding(.init(5.0))
                                }
                        }
                        HStack{
                            ForEach(0..<arrayf4.count){ index in
                                 ButtonView(text: self.arrayf4[index], width: 75, height: 75,textfield: self.$textfield, outText: self.$outText)
                                 .padding(.init(5.0))
                                }
                        }
                        HStack{
                            ForEach(0..<arrayf5.count){ index in
                                if(index == 0){
                                     ButtonView(text: self.arrayf5[index], width: 166, height: 75, textfield: self.$textfield, outText: self.$outText)
                                    .padding(.init(5.0))
                                }else{
                                     ButtonView(text: self.arrayf5[index], width: 75, height: 75,  textfield: self.$textfield, outText: self.$outText)
                                    .padding(.init(5.0))
                                }
                                }
                        }
                    
                    }
                }
            }
            
        }
       
    }


struct ButtonView:View {
    var text:String
    var width:CGFloat
    var height:CGFloat
    @Binding var textfield : String
    @Binding var outText : String
    var body: some View{
        ZStack{
            Button.init(action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                if(String(self.textfield.last ?? "a") == self.text){
                    if canRepeat(str: self.textfield.last!) {
                        self.textfield.append(self.text)
                    }
                }else {
                    if beforeAndAfter(str1: String(self.textfield.last ?? "a"), str2: self.text) {
                        
                    }else {
                        if(self.textfield.last ?? "a" == "="){
                            self.textfield = ""
                            self.outText = ""
                        }else if (self.textfield == "" && canBeFirst(str: Character(self.text))){
                            self.textfield.append(self.text)
                        }else if (self.textfield != ""){
                            self.textfield.append(self.text)
                        }
                    }
                    
                }
                if(self.text == "="){
                    if(arrangement(textField: self.textfield) == "inf") {
                         self.outText = "ERROR"
                    }else {
                         self.outText = arrangement(textField: self.textfield)
                    }
                }
                if(self.text == "C"){
                    self.textfield = ""
                    self.outText = ""
                }
                
            }) {
                if(text == "0"||text == "C"||text == "("||text == ")"||text == "/"||text == "X"||text == "-"||text == "+"||text == "="){
                    if (text == "0") {
                        Text(text)
                                           .font(.largeTitle)
                                           .foregroundColor(.white)
                                           .frame(width:  self.width, height: self.height, alignment: .center)
                                           .background(Color.init(red: 50/255.0, green: 51/255.0, blue: 52/255.0))
                                           .cornerRadius(50)
                    }else if(text == "C"||text == "("||text == ")") {
                        Text(text)
                                           .font(.largeTitle)
                                           .foregroundColor(.white)
                                           .frame(width:  self.width, height: self.height, alignment: .center)
                                           .background(Color.init(red: 164/255.0, green: 165/255.0, blue: 166/255.0))
                                           .cornerRadius(50)
                    }else {
                        Text(text)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width:  self.width, height: self.height, alignment: .center)
                        .background(Color.init(red: 250/255.0, green: 159/255.0, blue: 43/255.0))
                        .cornerRadius(50)
                    }
                }else{
                    Text(text)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width:  self.width, height: self.height, alignment: .center)
                    .background(Color.init(red: 50/255.0, green: 51/255.0, blue: 52/255.0))
                    .clipShape(Circle())
                }
            }
        }
    }
    
}
func isSymbol(str:Character) ->Bool {
    if (str == "-"||str == "+" || str == "X" || str == "/") {
        return false
    }
    return true
}
func canRepeat(str:Character) ->Bool {
    if (str == "-"||str == "+" || str == "X" || str == "/"||str == "."||str == "("||str == ")") {
        return false
    }
    return true
}
func canBeFirst(str:Character) ->Bool {
    if (str == "-"||str == "+" || str == "X" || str == "/"||str == ")"||str == ".") {
        return false
    }
    return true
}

func arrangement(textField:String) -> String  {
    var num : String = ""
    var temp:String = ""
    var array:[String] = []
    for item in textField {
        if (isSymbol(str: item)) {
            if num == "" {
                    num = String(item)
                }else{
                if item == "=" {
                    array.insert(num, at: array.count)
                }else {
                     num.append(item)
                }
            }
        }else {
            temp = String(item)
            array.insert(num, at: array.count)
            array.insert(temp, at: array.count)
            num = ""
    }
    }
    var tempNum1:String
    var tempNum2:String
    var tempNum3:String
    
    for index in (0..<array.count).reversed() {
        if (array[index] == "X"||array[index] == "/"){
            if (array[index] == "X") {
                tempNum1 = array[index - 1]
                tempNum2 = array[index + 1]
                tempNum3 = multiplication(num1: tempNum1, num2: tempNum2)
                let range = index-1...index+1
                array.removeSubrange(range)
                array.insert(tempNum3, at: index-1)
            }else {
                tempNum1 = array[index - 1]
                tempNum2 = array[index + 1]
                tempNum3 = division(num1: tempNum1, num2: tempNum2)
                let range = index-1...index+1
                array.removeSubrange(range)
                array.insert(tempNum3, at: index-1)
            }
            }
    }
    return plusAndSubtraction(array: array)
}

func plusAndSubtraction(array:Array<String>) -> String {
    var tempNum1:String
    var numArray:Array<String>  = ["0"]
    numArray.insert(array[0], at: numArray.count)
    for index in (0..<array.count){
        if (array[index] == "+"||array[index] == "-"){
            tempNum1 = array[index+1]
            if array[index] == "+" {
                numArray.insert(tempNum1, at: numArray.count)
            }else {
                var a = (tempNum1 as NSString).doubleValue
                a = -a
                numArray.insert(String(a), at: numArray.count)
                
            }
        }
    }
    if(numArray.last! == "inf"){
        return "ERROR"
    }else {
        var sum:Double = 0.0
        for index in numArray {
            let a = (index as NSString).doubleValue
            sum += a
        }
        return String(sum)
    }
    
}
func plus (num1 :String,num2:String) ->String {
    let a =  Float(num1)
    let b =  Float(num2)
    return String(a! + b!)
}
func subtraction (num1 :String,num2:String) ->String {
    let a =  Float(num1)
    let b =  Float(num2)
    return String(a! - b!)
}

func multiplication (num1 :String,num2:String) ->String {
   let a =  Float(num1)
    let b =  Float(num2)
    return String(a! * b!)
}
func division (num1 :String,num2:String) ->String {
   let a =  Float(num1)
    let b =  Float(num2)
    return String(a! / b!)
}
struct textView:UIViewRepresentable {
    
    @Binding var textfield : String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = UIColor.init(red: 0, green: 1/255.0, blue: 2/255.0, alpha: 1.0)
        textView.textColor = UIColor.white
        textView.isSelectable = false
        textView.font = .systemFont(ofSize: 80)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return textView
        
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = textfield
        uiView.scrollRangeToVisible(NSMakeRange(textfield.count, 1))
        switch textfield.count {
        case 9...:
            uiView.font = .systemFont(ofSize: 40)
        case 8:
            uiView.font = .systemFont(ofSize: 50)
        case 7:
        uiView.font = .systemFont(ofSize: 60)
        case 6:
            uiView.font = .systemFont(ofSize: 70)
        default:
            uiView.font = .systemFont(ofSize: 80)
        }
    }
    
    
}
func beforeAndAfter (str1:String,str2:String) ->Bool {
    if (canRepeat(str: Character(str1)) || canRepeat(str: Character(str2))) {
        return false
    }
    return true
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
