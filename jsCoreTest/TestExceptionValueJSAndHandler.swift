//
//  TestExceptionValueJSAndHandler.swift
//  jsCoreTest
//

import Foundation
import JavaScriptCore

class TestExceptionValueJSAndHandler {
	var context: JSContext!

	func start() {
		context = JSContext()

		print("\n\n" + String.init(describing: self))
		context.exceptionHandler = { context, exc in
			print("ExceptionTriggered: \(String(describing: exc))")
			print("exception in handler: \(String(describing: self.context.exception))")
			context?.exception = exc
		}

		// create object
		let object = JSValue(newObjectIn: context)!
		
		// create descriptor for adding a property with a getter
		var descriptorDictionary: [String: Any] = [:]
		let propertyName = "aProperty"
		
		// define getter
		let getter: @convention(block) () -> JavaScriptCore.JSValue = { [weak context] in
			context!.evaluateScript("throw Error('error set from JS')")
			
			return JSValue(object: "aValue", in: context)
		}
		descriptorDictionary[JSPropertyDescriptorGetKey] = JSValue(object: getter, in: self.context)
		
		// create property
		object.defineProperty(propertyName, descriptor: descriptorDictionary)
		
		print("object.forProperty = \(String(describing: object.forProperty(propertyName)))")
		print("exception after: \(String(describing: self.context.exception))")
	}
}


/*
iOS 12.2

TestExceptionValueJSAndHandler(context: <JSContext: 0x600001cfb900>)
ExceptionTriggered: Optional(Error: error set from JS)
exception in handler: nil
object.forProperty = Optional(aValue)
exception after: nil
__________________________________________________________________________

iOS 12.2 - //setting context.exception =exc
TestExceptionValueJSAndHandler(context: <JSContext: 0x600002fba9a0>)
ExceptionTriggered: Optional(Error: error set from JS)
exception in handler: nil
object.forProperty = nil
exception after: nil


*/
