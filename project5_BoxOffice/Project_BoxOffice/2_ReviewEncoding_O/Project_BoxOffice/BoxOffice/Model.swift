//
//  Model.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/08.
//

import Foundation
import UIKit

// MARK: - [ㅇ] 영화목록 구조체 - Movie struct
struct MovieList: Codable {
    var order_type: SortType
    var movies: [Movie]
}

struct Movie: Codable, Hashable {
    let thumb: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String
    let grade: Int
    let reservation_grade: Int
    let title: String
    
    var descriptionOfRating: (String, String) {
        // for table
        let table: String = "평점 : \(user_rating) | 예매순위 : \(reservation_grade) | 예매율 : \(reservation_rate)"
        
        // for collectionView
        let collection: String = "평점 : \(user_rating)\n예매순위 : \(reservation_grade)\n예매율 : \(reservation_rate)"
        return (table, collection)
    }
    
    var openingdate: String {
        return "개봉일 : \(date)"
    }
    
    var posterImage: UIImage {
        var resultImage = UIImage()
        guard let imageURL: URL = URL(string: thumb), let imageData: Data = try? Data(contentsOf: imageURL) else { return resultImage }
        
        resultImage = UIImage(data: imageData) ?? resultImage
        return resultImage
    }
    
    var gradeIcon: UIImage {
        var resultImage: UIImage
        var iconName: String = "ic_"
        switch grade {
        case 0:
            iconName.append("allages")
        case 12:
            iconName.append("12")
        case 15:
            iconName.append("15")
        case 19:
            iconName.append("19")
        default:
            print("\n Model - gradeIcon / [안내] 존재하지 않는 관람가입니다.")
        }
        resultImage = UIImage(named: iconName) ?? UIImage()
        
        return resultImage
    }
}

// MARK: - [ㅇ] 영화소개 구조체
struct MovieDetail: Codable {
    let audience: Int
    let grade: Int
    let actor: String
    let duration: Int
    let reservation_grade: Int
    
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let director: String
    
    let id: String
    let image: String
    let synopsis: String
    let genre: String
    
    var gradeIcon: UIImage {
        var resultImage: UIImage
        var iconName: String = "ic_"
        switch grade {
        case 0:
            iconName.append("allages")
        case 12:
            iconName.append("12")
        case 15:
            iconName.append("15")
        case 19:
            iconName.append("19")
        default:
            print("\n Model - gradeIcon / [안내] 존재하지 않는 관람가입니다.")
        }
        resultImage = UIImage(named: iconName) ?? UIImage()
        return resultImage
    }
    
    var genreAndDuration: String {
        return "\(genre) / \(duration)분"
    }
    
    var reserveRankAndRate: String {
        return "\(reservation_grade)위 \(reservation_rate)%"
    }
    
    var rateStar: NSAttributedString {
        var number = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        let imageHalfAttachment = NSTextAttachment()
        let imageEmptyAttachment = NSTextAttachment()
        
        let img = UIImage(named: "ic_star_large_full")
        let star = img?.resize(newWidth: 17)
        imageAttachment.image = star
        
        let img2 = UIImage(named: "ic_star_large_half")
        let star2 = img2?.resize(newWidth: 17)
        imageHalfAttachment.image = star2
        
        let img3 = UIImage(named: "ic_star_large")
        let star3 = img3?.resize(newWidth: 17)
        imageEmptyAttachment.image = star3
        
        let starFull = NSAttributedString(attachment: imageAttachment)
        let starHalf = NSAttributedString(attachment: imageHalfAttachment)
        let starEmpty = NSAttributedString(attachment: imageEmptyAttachment)
        
        // MARK: - [ㅇ] 별점 5점으로 환산 (9.8/1/2 = 4.9)
        let count: Int = Int((user_rating * 0.5) / 1)
        let remain: Double =  ((user_rating * 0.5) / 1) - Double(count)
        
        var index = 0
        for _ in 1...count {
            number.append(starFull)
            index += 1
        }
        
        var range = 1...(5-count)
        
        if remain > 0.3 && remain < 1 { // 0.3초과의 나머지 수가 있을 때
            range = 0...((4-index)) // 별 반개 추가하고 인덱스 하나 줄임
            number.append(starHalf)
            
            if index == 1 { // 2번째 자리에서 별 반개 추가됐을 때
                for _ in 1...3 { // ㅇ빈별 3개 추가
                    number.append(starEmpty)
                }
            } else if index == 2 { // 3번째 자리에서 별 반개 추가됐을 때
                for _ in 1...2 { // ㅇ빈별 1개 추가
                    number.append(starEmpty)
                }
            } else if index == 3 { // 4번째 자리에서 별 반개 추가됐을 때
                for _ in 1...1 { // ㅇ빈별 1개 추가
                    number.append(starEmpty)
                }
            }
        }
        else { // 0.3이하의 나머지일 경우 - 나머지를 버리고 빈별로 채움
            for _ in range {
                number.append(starEmpty)
            }
        }
        return number
    }
    
}

// MARK: - [ㅇ] 영화 정렬순서 / 0: 예매율(default), 1: 큐레이션, 2: 개봉일
enum SortType: Int, Codable {
    case reservation, curation, openingDate
}

class MovieShared {
    static var shared = MovieShared()
    var movieList: MovieList? = nil
    var movieDetail: MovieDetail? = nil
    var movieComments: MovieComments? = nil
    
    private init() { }
}

struct Comment: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movie_id: String
    let contents: String
    
    var writtenDate: String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM:ss"
        
        return "\(dateFormatter.string(from: date))"
    }
    
    var rateNumberUnderTwo: Double {
        let inputNumber = String(format: "%.2f", rating) // 40.000
        return Double(inputNumber)!
    }
    var rateStar: NSAttributedString {
        var number = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        let imageHalfAttachment = NSTextAttachment()
        let imageEmptyAttachment = NSTextAttachment()
        
        let img = UIImage(named: "ic_star_large_full")
        let star = img?.resize(newWidth: 17)
        imageAttachment.image = star
        
        let img2 = UIImage(named: "ic_star_large_half")
        let star2 = img2?.resize(newWidth: 17)
        imageHalfAttachment.image = star2
        
        let img3 = UIImage(named: "ic_star_large")
        let star3 = img3?.resize(newWidth: 17)
        imageEmptyAttachment.image = star3
        
        let starFull = NSAttributedString(attachment: imageAttachment)
        let starHalf = NSAttributedString(attachment: imageHalfAttachment)
        let starEmpty = NSAttributedString(attachment: imageEmptyAttachment)
        
        // MARK: - [ㅇ] 별점 5점으로 환산 (9.8/1/2 = 4.9)
        let count: Int = Int((rateNumberUnderTwo * 0.5) / 1)
        let remain: Double =  ((rateNumberUnderTwo * 0.5) / 1) - Double(count)
        var index = 0
        if count != 0 {
            for _ in 1...count {
                number.append(starFull)
                index += 1
            }
            if count < 5 {
                var range = 1...(5-count)
                if remain > 0.3 && remain < 1 { // 0.3초과의 나머지 수가 있을 때
                    range = 0...((4-index)) // 별 반개 추가하고 인덱스 하나 줄임
                    number.append(starHalf)
                    
                    if index == 1 { // 2번째 자리에서 별 반개 추가됐을 때
                        for _ in 1...3 { // ㅇ빈별 3개 추가
                            number.append(starEmpty)
                        }
                    } else if index == 2 { // 3번째 자리에서 별 반개 추가됐을 때
                        for _ in 1...2 { // ㅇ빈별 1개 추가
                            number.append(starEmpty)
                        }
                    } else if index == 3 { // 4번째 자리에서 별 반개 추가됐을 때
                        for _ in 1...1 { // ㅇ빈별 1개 추가
                            number.append(starEmpty)
                        }
                    }
                }
                else { // 0.3이하의 나머지일 경우 - 나머지를 버리고 빈별로 채움
                    for _ in range {
                        number.append(starEmpty)
                    }
                }
            }
            
        }
        else {
            for _ in 0...4 {
                number.append(starEmpty)
            }
        }
        
        return number
    }
}

struct MovieComments: Codable {
    let movie_id: String
    var comments: [Comment]
}

struct UserWriteComment: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movie_id: String
    let contents: String
}

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
}
