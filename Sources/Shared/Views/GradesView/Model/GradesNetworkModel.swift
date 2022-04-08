//
//  GradesNetworkRequest.swift
//  SMHSSchedule (iOS)
//
//  Created by Jevon Mao on 6/27/21.
//

import Combine
import Foundation

struct GradesNetworkModel {
    func fetch(with request: URLRequest) -> AnyPublisher<Bool, RequestError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .tryMap{_, response in
                guard let response = response as? HTTPURLResponse else {
                    preconditionFailure("Cannot cast response into HTTPURLResponse")
                }
                guard 200..<300 ~= response.statusCode else {
                      switch response.statusCode {
                      case 401:
                          throw RequestError.validationError(error: "The username and password entered are incorrect.")
                      case 429:
                          throw RequestError.failedAttempts(error: "Too many failed login attempts, try again after 5 minutes.")
                      case 408:
                          throw RequestError.timeoutError(error: "Timeout waiting for the main grades page to load, try again later.")
                      case 400:
                          throw RequestError.emptyPassword(error: "Password must not be empty")
                      default:
                          throw RequestError.unknownError(error: "Unknown error occured. Please file a bug report.")
                      }
                }
                return true
            }
            .mapError {error -> RequestError in
                switch error {
                case RequestError.validationError(let error):
                    return .validationError(error: error)
                default:
                    return .unknownError(error: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }

    func fetch<T: Decodable>(with request: URLRequest, type: T.Type) -> AnyPublisher<T, RequestError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .tryMap{data, response in
                guard let response = response as? HTTPURLResponse else {
                    preconditionFailure("Cannot cast response into HTTPURLResponse")
                }
                guard 200..<300 ~= response.statusCode else {
                      switch response.statusCode {
                      case 401:
                          throw RequestError.validationError(error: "The username and password entered are incorrect.")
                      case 429:
                          throw RequestError.failedAttempts(error: "Too many failed login attempts, try again after 5 minutes.")
                      case 408:
                          throw RequestError.timeoutError(error: "Timeout waiting for the main grades page to load, try again later.")
                      case 400:
                          throw RequestError.emptyPassword(error: "Password must not be empty")
                      default:
                          throw RequestError.unknownError(error: "Unknown error occured. Please file a bug report.")
                      }
                }
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .mapError {error -> RequestError in
                switch error {
                case RequestError.validationError(let error):
                    return .validationError(error: error)
                default:
                    return .unknownError(error: "")
                }
            }
            .eraseToAnyPublisher()
    }

//    func getLoginAndFetchRequest(email: String,
//                                 password: String,
//                                 debugMode: Bool) ->  {
//        let loginEndpoint = Endpoint.studentLogin(email: email,
//                                             password: password,
//                                             debugMode: debugMode)
//        let getSummaryEndpoint = Endpoint.getGradesSummary()
//        let summarySupplementEndpoint = Endpoint.getGradesSummarySupplement()
//
//        let getSummarySupplementPublisher = fetch(with: summarySupplementEndpoint.request,
//                                                                     type: [GradesSupplementSummary].self)
//
//        return fetch(with: loginEndpoint.request)
//            .flatMap {[unowned self] _ in
//                fetch(with: getSummaryEndpoint.request,
//                                              type: CourseGrade.self)
//                    .combineLatest(getSummarySupplementPublisher)
//                    .eraseToAnyPublisher()
//
//            }
//            .retry(2)
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//    }
}
