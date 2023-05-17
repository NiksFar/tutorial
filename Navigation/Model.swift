//
//  Model.swift
//  Navigation
//
//  Created by Никита on 21.02.2023.
//

import Foundation

struct Post {
    var title: String
}

func choosen() {

    let choosenPost = Post(title: "Here is choosen post")

    let postViewController = PostViewController()

    postViewController.postTitle = choosenPost
}
