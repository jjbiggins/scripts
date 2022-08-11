#!/usr/bin/env swift

func backward(_ s1: String, _ s2: String ) -> Bool {
    return s1 > s2;
}

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
var reversedNames = names.sorted(by: backward);
print(names);
print(reversedNames);
