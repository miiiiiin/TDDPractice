//
//  Course.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation

//struct CoursesByRolesRaw: Decodable {
//    var studentCourses: [String]
//    var teacherCourses: [String]
//}
//
//struct CoursesByRoles {
//    var student: [StudentCourse]
//    var teacher: [TeacherCourse]
//
//    func course(for indexPath: IndexPath) -> Course? {
//        if indexPath.section == 0, indexPath.item < student.count {
//            return student[indexPath.item]
//        } else if indexPath.section == 1, indexPath.item < teacher.count {
//            return teacher[indexPath.item]
//        }
//        return nil
//    }
//
//    func indexPath(for courseCode: String) -> IndexPath? {
//        if let index = student.firstIndex(where: { $0.code == courseCode }) {
//            return IndexPath(item: index, section: 0)
//        } else if let index = teacher.firstIndex(where: { $0.code == courseCode }) {
//            return IndexPath(item: index, section: 1)
//        }
//        return nil
//    }
//}
