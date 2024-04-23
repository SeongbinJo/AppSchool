
func makeDuplicated<나중에_넣을_타입1, 나중에_넣을_타입2: Hashable>(of item: 나중에_넣을_타입1, withKey keys: Set<나중에_넣을_타입2>) -> [나중에_넣을_타입2: 나중에_넣을_타입1] {
    var duplicates = [나중에_넣을_타입2: 나중에_넣을_타입1]()
    for key in keys {
        duplicates[key] = item
    }
    return duplicates
}


let awards: Set<String> = ["Best Director",
                           "Best Picture",
                           "Best Original Screenplay",
                           "Best International Feature"]

let oscars2020 = makeDuplicated(of: "Parasite", withKey: awards)
print(oscars2020["Best Picture"] ?? "")
print(oscars2020["Best Director"] ?? "")
print(oscars2020["Best Original Screenplay"] ?? "")
print(oscars2020["Best International Feature"] ?? "")
