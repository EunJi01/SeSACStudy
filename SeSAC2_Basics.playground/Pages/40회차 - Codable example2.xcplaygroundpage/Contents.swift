//: [Previous](@previous)

import UIKit

let json = """
{
"quote": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author": "John Lennon"
}
"""

// Json -> Struct : 디코딩, Struct -> Json : 인코딩
struct Quote: Decodable {
    let quoteContent: String?
    let authorName: String?
}

// String -> Data
guard let result = json.data(using: .utf8) else { fatalError("Error") }
print(result)

// Data -> Quote
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.quoteContent)
    print(value.authorName)
} catch {
    print(error)
}

//: [Next](@next)
