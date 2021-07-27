//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol MoviesView: AnyObject {
    func show(error: String)
    func insertItems(at indexPaths: [IndexPath])
    func reloadItems(at indexPaths: [IndexPath])
}

protocol MoviesPresenter {
    func viewDidLoad()
    func scrolledToTheEnd()
    func numberOfItems() -> Int
    func viewModel(at index: Int) -> Movie
    func didSelectItem(at index: Int)
}

final class DefaultMoviesPresenter {
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

        let insertIndexPaths = (0..<movies.count).map { IndexPath(row: firstIndex + $0, section: 0) }
        view?.insertItems(at: insertIndexPaths) // update view with loaded data, before fetching images

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
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.loadedMovies[index].image = image
                    DispatchQueue.main.async {
                        self.view?.reloadItems(at: [.init(item: index, section: 0)])
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.setDefaultImage(at: index)
                    }
                }
            }
        }
    }

    private func setDefaultImage(at index: Int) {
        
    }
}

extension DefaultMoviesPresenter: MoviesPresenter {
    func viewDidLoad() {
        loadNextPage()
    }

    func scrolledToTheEnd() {
        loadNextPage()
    }
    
    func numberOfItems() -> Int {
        loadedMovies.count
    }

    func viewModel(at index: Int) -> Movie {
        loadedMovies[index]
    }

    func didSelectItem(at index: Int) {
        // navigate to details
    }
}
