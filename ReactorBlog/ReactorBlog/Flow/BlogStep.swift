//
//  BlogStep.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/26.
//

import RxFlow

enum BlogStep: Step {
    case main
    case postDetail(post: Post)
}
