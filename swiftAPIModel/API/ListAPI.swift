/*
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

//  Mohammad Dawi April 6,2019

import Foundation
import UIKit

//API Singelton class
final class LibraryAPI {
    // 1
    static let shared = LibraryAPI()
    private let httpClient = HTTPClient()
    private let isOnline = true
    // 2
    
    func getRepos(url:String?,itemType:String?,completion: @escaping (/*[Repository]*/[Item]) -> Void){
        httpClient.getRepos(url: url, itemType: itemType,completion:{(error) in
            if(error == nil){
                completion(self.getRepos2())
            }
            else{
                completion(/*[Repository]*/[Item]())
            }
        })
    }
    
    func getRepos2() -> /*[Repository]*/[Item]{
        return httpClient.repos
    }
    
    func getReposTotalCount() -> Int  {
        return httpClient.totalCount
    }
}
