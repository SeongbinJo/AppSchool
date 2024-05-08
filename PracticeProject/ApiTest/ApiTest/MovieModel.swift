//
//  MovieModel.swift
//  ApiTest
//
//  Created by 조성빈 on 4/30/24.
//

import Foundation

struct Movie: Identifiable, Hashable, Codable {
    var id: Int // 823464 -> 영화 식별 ID
    var adult: Bool // false -> 성인영화 구별
    var backdrop_path: String // /qrGtVFxaD8c7et0jUtaYhyTzzPg.jpg -> 배경 이미지
    var genre_ids: [Int] // [28, 878, 12] -> 장르 구별 번호
    var original_language: String // en -> 원어
    var original_title: String // Godzilla x Kong: The New Empire -> 원제목,    이미지 경로 확인 URL = https://image.tmdb.org/t/p/original/이미지경로
    var overview: String // 고질라 X 콩, 이번에는 한 팀이다!... -> 영화 내용
    var popularity: Double
    var poster_path: String // /4z1VMmlxHrziG45901esjB4dpIa.jpg -> 공식 포스터 이미지,    이미지 경로 확인 URL = https://image.tmdb.org/t/p/original/이미지경로
    var release_date: String // 2024-03-27 -> 영화 개봉 날짜
    var title: String // 고질라 X 콩: 뉴 엠파이어 -> 한국어 제목
    var video: Bool // false -> 예고편 여부
    var vote_average: Double // 6.64 -> 평점
    var vote_cound: Int // 798 -> 평가 수
}
