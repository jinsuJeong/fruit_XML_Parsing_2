//
//  ViewController.swift
//  fruit_XML_Parsing_2
//
//  Created by D7703_18 on 2018. 9. 17..
//  Copyright © 2018년 201550057. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    //데이터 클래스 객체 배열
    var myFruitData = [FruitData]()
    
    var dName = ""
    var dcolor = ""
    var dcost = ""
    
    //현재의 tag를 저장
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fruit.xml 파일을 가져오기
        // optional binding nil check
        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
            // 파싱 시작
            if let myParser = XMLParser(contentsOf: path) {
                //delegate를 viewcontroller와 연결
                myParser.delegate = self
                if myParser.parse(){
                    print("Parsing complate!")
                    //                    print(myFruitData[0].name)
                    //                    print(myFruitData[0].color)
                    //                    print(myFruitData[0].cost)
                    
                }else{
                    print("Parsing nil!")
                }
            }
            
        }else {
            print("XML file not found!")
        }
        //print(path)
    }
    
    //xml parser delegate 메소드
    //1. tag(element)를 만나면 실행
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        currentElement = elementName
    }
    
    //2. tag 다음에 문자열을 만날 때
    func parser(_ parser: XMLParser, foundCharacters string: String){
        let data = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            switch currentElement{
            case "name" : dName = data
            case "color" : dcolor = data
            case "cost" : dcost = data
            default : break
            }
        }
    }
    
    //3. tag가 끝날때 실행(/tag)
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if elementName == "item"{
            let myItem = FruitData()
            myItem.name = dName
            myItem.color = dcolor
            myItem.cost = dcost
            myFruitData.append(myItem)
        }
    }
}
