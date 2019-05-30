//
//  TestExceptionValue.swift
//  jsCoreTest
//

import Foundation
import JavaScriptCore

class TestExceptionValue {
	var context: JSContext!
	
	func start() {
		context = JSContext()
		
		print("\n\n" + String.init(describing: self))

		// create object
		let object = JSValue(newObjectIn: context)!

		// create descriptor for adding a property with a getter
		var descriptorDictionary: [String: Any] = [:]
		let propertyName = "aProperty"
		// define getter
		let getter: @convention(block) () -> JavaScriptCore.JSValue = { [weak context] in
			context!.exception = JSValue(newErrorFromMessage: "Error set from Swift",
										 in: context)
			
			return JSValue(object: "aValue", in: context)
		}
		descriptorDictionary[JSPropertyDescriptorGetKey] = JSValue(object: getter, in: self.context)
		
		// create property
		object.defineProperty(propertyName, descriptor: descriptorDictionary)
		
		print("object.forProperty = \(String(describing: object.forProperty(propertyName)))")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			print("exception after: \(String(describing: self.context.exception))")
		}
	}
}

/*

This tests the behavior when setting an exception on the JSContext from Swift.

____________________________________________________________________________
iOS 12.2 Output:

object.forProperty = nil
exception after: nil

____________________________________________________________________________
iOS < 12.2 Output:

object.forProperty = Optional(undefined)
exception after: Optional(Error: Error set from Swift)

*/


