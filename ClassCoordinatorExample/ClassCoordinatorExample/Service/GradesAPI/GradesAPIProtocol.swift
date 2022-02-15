//
//  GradesAPIProtocol.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation
import RxSwift

protocol HasGradesAPI {
    var gradesApi: GradesAPIProtocol { get }
}

protocol GradesAPIProtocol {
    // MARK: GET

    func getUser() -> Observable<User>
//    func getTeacherCourses(username: String) -> Observable<[TeacherCourse]>
//    func getStudentCourses(username: String) -> Observable<[StudentCourse]>
//    func getCourse(code: String) -> Observable<Course>
//    func getCourseStudentClassification(username: String, code: String) -> Observable<[Classification]>
//    func getCurrentSemestrCode() -> Observable<String>
//    func getStudentGroups(forCourse course: String, username: String?) -> Observable<[StudentGroup]>
//    func getClassifications(forCourse: String) -> Observable<[Classification]>
//    func getGroupClassifications(courseCode: String, groupCode: String, classificationId: String) -> Observable<[StudentClassification]>
//    func getTeacherStudents(courseCode: String) -> Observable<[User]>
//    func getNewNotifications(forUser: String) -> Observable<Notifications>
//
//    // MARK: PUT
//
//    func putStudentsClassifications(courseCode: String, data: [StudentClassification], notify: Bool) -> Observable<Void>
//    func markNotificationRead(username: String, notificationId: Int) -> Observable<Void>
}
