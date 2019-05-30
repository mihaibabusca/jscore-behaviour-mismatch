//
//  TestExceptionHandlerTiggeredBySwift.swift
//  jsCoreTest
//

import Foundation
import JavaScriptCore

class TestExceptionHandlerTriggeredBySwift {
	var context: JSContext!

	func start() {
		context = JSContext()

		print("\n\n" + String.init(describing: self))
		
		context.exceptionHandler = { context, exc in
			print("ExceptionTriggered: \(String(describing: exc))")
			print("exception in handler: \(String(describing: self.context.exception))")
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			print("exception after: \(String(describing: self.context.exception))")
		}
		
		let result = context.evaluateScript(scriptF())!
		print("object.forProperty = \(String(describing: result.forProperty("enableHighAccuracy")))")
	}
	
	func scriptF() -> String {
		return
				"""
				Object.create(Object.prototype, {
				enableHighAccuracy: {
				get: function() {
				throw new Error("Boom!");
				}
				}
				});
				"""
	}
}

/*

Results:

iOS 11.3:  JS error, thrown in JS, called in SWIFT (forProperty), triggers handler

iOS 12.2:  JS error, thrown in JS, called in SWIFT (forProperty), DOES NOT trigger handler

*/
