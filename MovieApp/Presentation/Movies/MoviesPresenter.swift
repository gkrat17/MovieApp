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
    func numberOfItems(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> MovieSummaryViewModel
    func didSelectItem(at indexPath: IndexPath)
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
        guard let pageIndexToLoad = pageState.returnThenIncrement() else { return }
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
                reloadWithDefaultImage(at: index)
            }
        }
    }

    private func load(image id: Movie.ImageId, at index: Int) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.useCase.execute(imageId: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.loadedMovies[index].image = image
                    DispatchQueue.main.async {
                        self.view?.reloadItems(at: [.init(item: index, section: 0)])
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.reloadWithDefaultImage(at: index)
                    }
                }
            }
        }
    }

    private func reloadWithDefaultImage(at index: Int) {
        
    }

    private func count() -> Int {
        loadedMovies.count
    }

    private func movie(at index: Int) -> Movie {
        loadedMovies[index]
    }
}

extension DefaultMoviesPresenter: MoviesPresenter {
    func viewDidLoad() {
        loadNextPage()
    }

    func scrolledToTheEnd() {
        loadNextPage()
    }

    func numberOfItems(in section: Int) -> Int {
        count()
    }

    func viewModel(at indexPath: IndexPath) -> MovieSummaryViewModel {
        movie(at: indexPath.row).summaryViewModel
    }

    func didSelectItem(at indexPath: IndexPath) {
        let model = movie(at: indexPath.row)
        navigator.navigate2Details(with: .init(movie: model))
    }
}

fileprivate extension Movie {
    var summaryViewModel: MovieSummaryViewModel {
        .init(
            name: name,
            rating: "\(averageRating)",
            image: image
        )
    }
}
