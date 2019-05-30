//
//  ViewController.swift
//  jsCoreTest
//
import UIKit
import JavaScriptCore

class ViewController: UIViewController {
	var testExceptionValue = TestExceptionValue()
	var testExceptionValueJS = TestExceptionValueJS()
	var testExceptionValueAndHandler = TestExceptionValueAndHandler()
	var testExceptionValueJSAndHandler = TestExceptionValueJSAndHandler()
	var testExceptionHandlerTriggeredBySwift = TestExceptionHandlerTriggeredBySwift()
	var testExceptionHandlerTriggeredByJS = TestExceptionHandlerTriggeredByJS()
  	var testExceptionTriggeredBySwift = TestExceptionTriggeredBySwift()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
	/*
	    1. Uncomment each test and run on simulator 12.2 and lower (e.g. 12.1, 11.3)
        2. Observe console output
		
		Note: The collected outputs, during our tests are also added at the bottom of each source file TestException*.swift"
	*/
		testExceptionValue.start()
//		testExceptionValueJS.start()
//		testExceptionValueAndHandler.start()
//		testExceptionValueJSAndHandler.start()
//		testExceptionHandlerTriggeredBySwift.start()
//		testExceptionHandlerTriggeredByJS.start()
//		testExceptionTriggeredBySwift.start()
	}
}
