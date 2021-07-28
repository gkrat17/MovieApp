//
//  DetailsPresenter.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol DetailsView: AnyObject {
    func show(error: String)
    func updateDetails(from movie: Movie)
    func insertItems(at indexPaths: [IndexPath])
}

protocol DetailsPresenter {
    func viewDidLoad()
    func scrolledToTheEnd()
    func numberOfItems(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> SimilarMovieViewModel
    func didSelectItem(at indexPath: IndexPath)
}

struct DetailsParams {
    let movie: Movie
}

final class DefaultDetailsPresenter {
    private let movie: Movie
    private weak var view: DetailsView?
    private let navigator: DetailsNavigator
    private let useCase: SimilarMoviesUseCase

    // State Variables
    private lazy var pageState: PageState = useCase.initialPageState()
    private var loadedSimilarMovies: [Movie] = []

    init(
        params: DetailsParams,
        view: DetailsView,
        navigator: DetailsNavigator,
        useCase: SimilarMoviesUseCase = DefaultSimilarMoviesUseCase()
    ) {
        movie = params.movie
        self.view = view
        self.navigator = navigator
        self.useCase = useCase
    }

    private func loadNextPage() {
        guard let pageIndexToLoad = pageState.returnThenIncrement() else { return }
        useCase.execute(movieId: movie.movieId, page: pageIndexToLoad) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.handle(movies: movies)
            case .failure(let error):
                self?.view?.show(error: error.errorMessage)
            }
        }
    }

    private func handle(movies: [Movie]) {
        let firstIndex = loadedSimilarMovies.count
        loadedSimilarMovies.append(contentsOf: movies)

        for i in (0..<movies.count) {
            if let id = movies[i].imageId {
                load(image: id, at: firstIndex + i)
            }
        }
    }

    private func load(image id: Movie.ImageId, at index: Int) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.useCase.execute(imageId: id) { [weak self] result in
                if case let .success(image) = result {
                    self?.loadedSimilarMovies[index].image = image
                }
                DispatchQueue.main.async { [weak self] in
                    self?.view?.insertItems(at: [.init(item: index, section: 0)])
                }
            }
        }
    }

    private func count() -> Int {
        loadedSimilarMovies.count
    }

    private func movie(at index: Int) -> Movie {
        loadedSimilarMovies[index]
    }
}

extension DefaultDetailsPresenter: DetailsPresenter {
    func viewDidLoad() {
        view?.updateDetails(from: movie)
        loadNextPage()
    }

    func scrolledToTheEnd() {
        loadNextPage()
    }

    func numberOfItems(in section: Int) -> Int {
        count()
    }

    func viewModel(at indexPath: IndexPath) -> SimilarMovieViewModel {
        movie(at: indexPath.row).similarMovieViewModel
    }

    func didSelectItem(at indexPath: IndexPath) {
        let model = movie(at: indexPath.row)
        navigator.navigate2Details(with: .init(movie: model))
    }
}

fileprivate extension Movie {
    var similarMovieViewModel: SimilarMovieViewModel {
        .init(
            name: name,
            image: image
        )
    }
}
