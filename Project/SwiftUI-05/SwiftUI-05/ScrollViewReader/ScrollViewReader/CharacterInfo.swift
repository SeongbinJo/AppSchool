//
//  CharactorInfo.swift
//  ScrollViewReader
//
//  Created by 조성빈 on 4/25/24.
//

import Foundation


struct CharacterInfo: Identifiable {
    var name: String
    var id: Int
}


extension CharacterInfo {
    static let charArray = [
            CharacterInfo (name:"a.circle.fill",id:0),
            CharacterInfo (name:"b.circle.fill",id:1),
            CharacterInfo (name:"c.circle.fill",id:2),
            CharacterInfo (name:"d.circle.fill",id:3),
            CharacterInfo (name:"e.circle.fill",id:4),
            CharacterInfo (name:"f.circle.fill",id:5),
            CharacterInfo (name:"g.circle.fill",id:6),
            CharacterInfo (name:"h.circle.fill",id:7),
            CharacterInfo (name:"i.circle.fill",id:8),
            CharacterInfo (name:"j.circle.fill",id:9),
            CharacterInfo (name:"k.circle.fill",id:10),
            CharacterInfo (name:"l.circle.fill",id:11),
            CharacterInfo (name:"m.circle.fill",id:12),
            CharacterInfo (name:"n.circle.fill",id:13),
            CharacterInfo (name:"o.circle.fill",id:14),
            CharacterInfo (name:"p.circle.fill",id:15),
            CharacterInfo (name:"q.circle.fill",id:16),
        ]
}
