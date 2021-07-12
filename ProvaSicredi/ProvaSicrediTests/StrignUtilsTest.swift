import XCTest

@testable import ProvaSicredi
class StrignUtilsTest: XCTestCase {
  
    func testValidEmail(){
        let emailTest = "nana"
        let secondEmailTest = "nana@"
        let thirdEmailTest = "nana@nana"
        let fourthEmailTest = "nana@nana.nana"
        let fithEmailTest = "nana@nana.nana.nana.nana.nana.nana"
        let sixthEmailTest = "nana@nana.nana.nana"
        let seventhEmailTest = "rafael.hartmann@ifsul.edu.br"
        
        let value1 = emailTest.isValidEmail
        let value2 = secondEmailTest.isValidEmail
        let value3 = thirdEmailTest.isValidEmail
        let value4 = fourthEmailTest.isValidEmail
        let value5 = fithEmailTest.isValidEmail
        let value6 = sixthEmailTest.isValidEmail
        let value7 = seventhEmailTest.isValidEmail
     
        
        XCTAssertFalse(value1, "\(emailTest) não é um email valido")
        XCTAssertFalse(value2, "\(secondEmailTest) não é um email valido")
        XCTAssertFalse(value3, "\(thirdEmailTest) não é um email valido")
        XCTAssert(value4, "\(fourthEmailTest) não é um email valido")
        XCTAssert(value5, "\(fithEmailTest) não é um email valido")
        XCTAssert(value6, "\(sixthEmailTest) não é um email valido")
        XCTAssert(value7, "\(seventhEmailTest) não é um email valido")
    }
}
