//
//  HomeViewModel.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import UIKit
import RxCocoa
import RxSwift
class HomeViewModel: BaseViewModel {
    let viewIsReady = PublishRelay<Void>()
    let listPostTrigger = PublishRelay<Void>()
    let listUserTrigger = PublishRelay<Void>()
    let listCommentTrigger = PublishRelay<Void>()
   
    let listPost = BehaviorRelay<[Post]>(value: [])
    let listUser = BehaviorRelay<[User]>(value: [])
    let listComment = BehaviorRelay<[Comment]>(value: [])
    
    let initalLoad = PublishRelay<Void>()
    
    private let postService = PostService()
    
    override init() {
        super.init()
        setupBinding()
    }
    
    
    private func setupBinding() {
        let requestTrigger = Observable.merge(
            viewIsReady.asObservable())
        
//        let getListPost = getListPost().asObservable()
//        let getListUser = getListUser().asObservable()

//        Observable
//            .zip(getListPost, getListUser).subscribe(
//                onCompleted: { [unowned self] in
//                    print("ps da xong")
//                    initalLoad.accept(())
//                    ActivityIndicator.shared.dismiss()
//                }).disposed(by: dispose)
        
        requestTrigger
            .subscribe(
                onNext: { [unowned self] _ in
                    listPostTrigger.accept(())
                    listUserTrigger.accept(())
                    listCommentTrigger.accept(())
                }).disposed(by: dispose)

        listPostTrigger
            .flatMapLatest({ [unowned self] in getListPost() })
            .bind(to: listPost)
            .disposed(by: dispose)

        listUserTrigger
            .flatMapLatest({ [unowned self] in getListUser() })
            .bind(to: listUser)
            .disposed(by: dispose)

        listCommentTrigger
            .flatMapLatest({ [unowned self] in getListComment() })
            .bind(to: listComment)
            .disposed(by: dispose)
        
        Observable.zip(listPost, listUser).subscribe(
            onNext: { [unowned self] i in
                initalLoad.accept(())
            }).disposed(by: dispose)
    }
    
    private func getListPost() -> Observable<[Post]> {
        return Observable.create { [unowned self] (observer) -> Disposable in
            postService.getListPost() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.errorMessage.accept(error.localizedDescription)
                case .success(let posts):
                    RealmManager.shared.write(data: posts)
                    observer.onNext(posts)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    private func getListUser() -> Observable<[User]> {
        return Observable.create { [unowned self] (observer) -> Disposable in
            postService.getListUser() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.errorMessage.accept(error.localizedDescription)
                case .success(let users):
                    RealmManager.shared.write(data: users)
                    observer.onNext(users)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    private func getListComment() -> Observable<[Comment]> {
        return Observable.create { [unowned self] (observer) -> Disposable in
            postService.getListComment() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.errorMessage.accept(error.localizedDescription)
                case .success(let comments):
                    RealmManager.shared.write(data: comments)
                    observer.onNext(comments)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
