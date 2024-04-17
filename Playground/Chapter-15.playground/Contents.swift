// 에러 타입 선언
enum FileTransferError: Error {
    case noConnection
    case lowBandWidth
    case fileNotFound
}

// 특정 상황을 가정하기위한 상수
let connectionOK = true
let connectionSpped = 31.00
let fileFound = true

// 에러 던지기
//func transferFile() throws -> Bool { // throws -> '이 함수는 에러를 가지고 있다.'
//    
//}

func fileTransfer() throws {
    guard connectionOK else {
        throw FileTransferError.noConnection
    }
    guard connectionSpped > 30 else {
        throw FileTransferError.lowBandWidth
    }
    guard fileFound else {
        throw FileTransferError.fileNotFound
    }
    // do something
}

// 함수 호출
func sendFile() -> String {
    
    // defer - 에러가 발생하던 하지 않던 반드시 실행되는 부분
    // defer는 윗쪽에 정의해주는 것이 좋다
    defer {
        print("End of sendFile.")
    }
    
    do {
        try fileTransfer() // try! 를 하면 에러가 발생해도 무시하라는 뜻임
    } catch FileTransferError.noConnection {
        return ("No Network Connection")
    } catch FileTransferError.lowBandWidth {
        return ("File Transfer Speed too low")
    } catch FileTransferError.fileNotFound {
        return ("File not found")
    } catch let error {
        return ("Unknown error : \(error)")
    }
    return ("Successful transfer!")
}

print(sendFile())

// 에러 객체에 접근
//do {
//    try filemgr.createDirectory(atPath: newDir, withIntermediateDirectories: true, attributes: nil)
//} catch let error {
//    print("Error: \(error.loccalizedDescription)")
//}
