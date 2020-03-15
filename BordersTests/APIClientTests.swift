//
//  APIClientTests.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import XCTest
import OHHTTPStubs
import RxSwift

@testable import Borders

class APIClientTests: XCTestCase {
    
    struct TestModel: JSONDecodable {
        let foo: String
        
        init?(dictionary: JSONDictionary) {
            guard let foo = dictionary["foo"] as? String else {
                return nil
            }
            
            self.foo = foo
        }
    }
    
    struct TestResource: Resource {
        let path: String = "object"
        let parameters: [String: String] = ["testing": "true"]
    }
    
    let client = APIClient(baseURL: URL(string: "http://test.com")!)
    let disposeBag = DisposeBag()
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testValidResponse() {
        stub(condition: isHost("test.com")) { request in
            XCTAssertEqual("http://test.com/object?testing=true", request.url?.absoluteString)
            
            let path = OHPathForFile("test.json", type(of: self))!
            return fixture(filePath: path, headers: nil)
        }
        
        let completed = self.expectation(description: "completed")
        let observable: Observable<[TestModel]> = client.objects(resource: TestResource())
        
        observable.subscribe(onNext: { models in
            XCTAssertEqual(1, models.count)
            XCTAssertEqual("bar", models[0].foo)
            
            completed.fulfill()
        }).disposed(by: disposeBag)

        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testBadStatus() {
        stub(condition: isHost("test.com")) { request in
            return OHHTTPStubsResponse(data: Data(), statusCode: 404, headers: nil)
        }
        
        let errored = self.expectation(description: "errored")
        let observable: Observable<[TestModel]> = client.objects(resource: TestResource())
        
        observable.subscribe(onError: { e in
            let error = e as! APIClientError
            switch error {
            case let .BadStatus(status):
                XCTAssertEqual(404, status)
            default:
                XCTFail()
            }
            errored.fulfill()
        }).disposed(by: disposeBag)
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
}
