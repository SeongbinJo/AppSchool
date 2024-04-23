struct PersonName {
    let givenName: String
    let familyName: String
}

enum CommunicationMethod {
    case phone
    case email
    case textMessage
    case fax
    case telepathy
    case subSpaceRelay
    case tachyons
}

enum Role: String {
    case captain = "Captain"
    case firstOfficer = "First Officer"
    case secondOfficer = "Second Officer"
    case chiefEngineer = "Chief Enginner"
    case councillor = "Councillor"
    case securityOfficer = "Security Officer"
    case chiefMedicalOfficer = "Chief Medical Officer"
}

class Person {
    let name: PersonName
    let preferredCommunicationMethod: CommunicationMethod
    
    convenience init(givenName: String, familyName: String, commsMethod: CommunicationMethod) {
        let name = PersonName(givenName: givenName, familyName: familyName)
        self.init(name: name, commsMethod: commsMethod)
    }
    
    init(name: PersonName, commsMethod: CommunicationMethod) {
        self.name = name
        preferredCommunicationMethod = commsMethod
    }
    
    var displayName: String {
        return "\(name.givenName) \(name.familyName)"
    }
}

var crew: [Role: Person] = [:]

crew[.captain] = Person(givenName: "Seongbin", familyName: "Jo", commsMethod: .phone)

crew[.firstOfficer] = Person(givenName: "William", familyName: "Riker", commsMethod: .email)

crew[.chiefEngineer] = Person(givenName: "Geordi", familyName: "LaForge", commsMethod: .textMessage)

crew[.secondOfficer] = Person(givenName: "Data", familyName: "Soong", commsMethod: .fax)

crew[.councillor] = Person(givenName: "Deanna", familyName: "Troi", commsMethod: .telepathy)

crew[.securityOfficer] = Person(givenName: "Tasha", familyName: "Yar", commsMethod: .subSpaceRelay)

crew[.chiefMedicalOfficer] = Person(givenName: "Beverly", familyName: "Crusher", commsMethod: .tachyons)


print(crew)

let roles = Array(crew.keys)
print(roles.first!)
print(crew[roles.first!]!.displayName)
