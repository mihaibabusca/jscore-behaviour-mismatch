//
//  TestExceptionHandlerTriggeredByJS.swift
//  jsCoreTest
//

import Foundation
import JavaScriptCore

class TestExceptionHandlerTriggeredByJS {
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
		
		context.exception = JSValue(bool: true, in: context)
		context.evaluateScript(scriptV())
	}
	
	func scriptV() -> String {
		return
			"""
			const obj = Object.create(Object.prototype, {
			enableHighAccuracy: {
			get: function() {
			throw new Error("Boom!");
			}
			}
			});
			console.log(obj.enableHighAccuracy)
			"""
	}
}

/*

Results:

iOS 11.3:
	JS error, thrown in JS, called in JS, triggers handler

iOS 12.2:
	JS error, thrown in JS, called in JS, triggers handler

*/
