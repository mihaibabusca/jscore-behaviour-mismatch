//
//  TestExceptionValueAndHandler.swift
//  jsCoreTest
//

import Foundation
import JavaScriptCore

class TestExceptionValueAndHandler {
	var context: JSContext!

	func start() {
		context = JSContext()
		
		print("\n\n" + String.init(describing: self))
		context.exceptionHandler = { context, exc in
			print("ExceptionTriggered: \(String(describing: exc))")
			print("exception in handler: \(String(describing: self.context.exception))")
		}
		
		// create object
		let object = JSValue(newObjectIn: context)!
		
		// create descriptor for adding a property with a getter
		var descriptorDictionary: [String: Any] = [:]
		let propertyName = "aProperty"
		
		// define getter
		let getter: @convention(block) () -> JavaScriptCore.JSValue = { [weak context] in
			context!.exception = JSValue(newErrorFromMessage: "Error set from Swift",
										 in: context)
			////
			// 2
 			// context?.evaluateScript("throw Error('Error from JS')")
			////
			
			return JSValue(object: "aValue", in: context)
		}
		descriptorDictionary[JSPropertyDescriptorGetKey] = JSValue(object: getter, in: self.context)
		
		// create property
		object.defineProperty(propertyName, descriptor: descriptorDictionary)
		
		print("object.forProperty = \(String(describing: object.forProperty(propertyName)))")
	}
}

/*

This tests the behavior when setting an exception on the JSContext from Swift and catching it in an exception handler.

____________________________________________________________________________
iOS 12.2 Output:

// exceptionHandler not triggered when assigning context.exception = JSValue...

TestExceptionValueAndHandler(context: <JSContext: 0x6000008caf70>)
object.forProperty = nil

____________________________________________________________________________
iOS 12.2 Output 2:

// exceptionHandler triggered when throwing from JS

ExceptionTriggered: Optional(Error: Error from JS)
exception in handler: Optional(Error: Error set from Swift)
object.forProperty = nil


____________________________________________________________________________
iOS < 12.2 Output:

TestExceptionValueAndHandler(context: <JSContext: 0x60c00005a010>)
ExceptionTriggered: Optional(Error: Error set from Swift)
object.forProperty = Optional(undefined)
exception after: nil

*/


