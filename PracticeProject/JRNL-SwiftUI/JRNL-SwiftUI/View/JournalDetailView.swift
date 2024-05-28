//
//  JournalDetailView.swift
//  JRNL-SwiftUI
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI

struct JournalDetailView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Text("May 29, 2024")
                        .fontWeight(.bold)
                }
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 0.5)
                
                HStack(spacing: 40) {
                    // 별점
                    ForEach(0..<5) {_ in
                        Button(action: {}) {
                            Image(systemName: "star")
                        }
                    }
                }
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 0.5)
                
                HStack {
                    Text("Title")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 0.5)
                
                ScrollView {
                    Text("hia;lkjfe;lkwjc;lakwme;lcma;wlemcl;kawmnerlkj;gha;lkjwenrf;lcanwkjlhervbalkwjenc;aklemr;vlkans;edklj mca;lwkremfc;lakwesmn;lkamwre;lgjhna;wlkemc;alwkmervclk;jna;lefjkn;lckma;lerkngaa;wlheca;lkjwe;lkcnmak;jshnrdg;laksjdl;fkcamwejhciklaㅕ봄대;ㅑㅓㅇ루;'ㅐㅣ냐드개햐머;재'댜츠ㅔqj3rfoija'l;kjgl;kㅓl;kfjal;sdkjf;laksjdfl;kja;sldkjgal;weimfco;aijerg;alkmowiaerjf;laiwmnefl;cfimal;weimrgl;iajwel;icmsl;eirmgl;iMWl;cimawe1231231231231231241234124asdfasdfawefawce")
                        .lineLimit(10)
                }
                .frame(maxHeight: 200)
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 0.5)
                
                Image(systemName: "face.smiling")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 0.5)
                
                Image(systemName: "map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            }
        }
        .padding()
    }
}

#Preview {
    JournalDetailView()
}
