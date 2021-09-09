#!/usr/bin/env swift

import Foundation


let path: String = "/Users/jjbiggins/mbox";
let fhandle : FileHandle? = FileHandle(forReadingAtPath: path)
let stdout = FileHandle.standardOutput
let contents = fhandle?.availableData

stdout.write(contents!)
