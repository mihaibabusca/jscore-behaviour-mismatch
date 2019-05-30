//
//  TestExceptionTriggeredBySwift.swift
//  jsCoreTest
//

import Foundation
import JavaScriptCore

class TestExceptionTriggeredBySwift {
	var context: JSContext!
	
	func start() {
		context = JSContext()

		print("\n\n" + String.init(describing: self))
		
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

iOS 11.3:
object.forProperty = Optional(undefined)
exception after: Optional(Error: Boom!)

_____________

iOS 12.2:

object.forProperty = Optional(null)
exception after: nil


*/
