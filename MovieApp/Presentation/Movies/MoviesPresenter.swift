//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol MoviesView: AnyObject {
    func show(error: String)
    func reloadItems(at: [Int])
}

protocol MoviesPresenter {
    func viewDidLoad()
}

final class DefaultMoviesPresenter: MoviesPresenter {
    private weak var view: MoviesView?
    private let navigator: MoviesNavigator
    private let useCase: PopularMoviesUseCase

    // State Variables
    private lazy var pageState: PageState = useCase.initialPageState()
    private var loadedMovies: [Movie] = []

    init(
        view: MoviesView,
        navigator: MoviesNavigator,
        useCase: PopularMoviesUseCase = DefaultPopularMoviesUseCase()
    ) {
        self.view = view
        self.navigator = navigator
        self.useCase = useCase
    }

    func viewDidLoad() {
        loadNextPage()
    }

    private func loadNextPage() {
        guard let pageIndexToLoad = pageState.returnThenIncrement()
        else {
            // do nothing
            return
        }
        useCase.execute(page: pageIndexToLoad) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.handle(movies: movies)
            case .failure(let error):
                self.view?.show(error: error.errorMessage)
            }
        }
    }

    private func handle(movies: [Movie]) {
        let firstIndex = loadedMovies.count
        loadedMovies.append(contentsOf: movies)

        let reloadIndices = (0..<movies.count).map { firstIndex + $0 }
        view?.reloadItems(at: reloadIndices) // update view with loaded data, before fetching images

        // start loading images
        for i in (0..<movies.count) {
            let index = firstIndex + i
            if let id = movies[i].imageId {
                load(image: id, at: index)
            } else {
                setDefaultImage(at: index)
            }
        }
    }

    private func load(image id: Movie.ImageId, at index: Int) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.useCase.execute(imageId: id) { [weak self] result in
                // this callback is called in main thread
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.loadedMovies[index].image = image
                    self.view?.reloadItems(at: [index])
                case .failure:
                    self.setDefaultImage(at: index)
                }
            }
        }
    }

    private func setDefaultImage(at index: Int) {
        
    }
}
