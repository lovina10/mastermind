//
//  Interactor.swift
//  Mastermind
//
//  Created by Lovina on 2/7/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import Foundation
import Alamofire

class Interactor {
    func fetchNumbers(completion: @escaping ([String]?) -> Void) {
        guard let url = URL(string: "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new") else {
            completion(nil)
            return
        }
        AF.request(url).responseString { (response) in
            switch response.result {
            case .success:
                if let value = response.value {
                    let splitNumbers = value.split(separator: "\n")
                    var numbersArray: [String] = []
                    for number in splitNumbers {
                        numbersArray.append(String(number))
                    }
                    completion(numbersArray)
                }
            case .failure:
                print("Error message:\(response.result)")
                completion(nil)
            }
        }
    }
}
