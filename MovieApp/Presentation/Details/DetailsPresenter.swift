//
//  DetailsPresenter.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol DetailsView: AnyObject {
    func updateDetails(from movie: Movie)
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
}

extension DefaultDetailsPresenter: DetailsPresenter {
    func viewDidLoad() {
        view?.updateDetails(from: movie)
    }

    func scrolledToTheEnd() {
        //
    }

    func numberOfItems(in section: Int) -> Int {
        0
    }

    func viewModel(at indexPath: IndexPath) -> SimilarMovieViewModel {
        .init(name: "", image: nil)
    }

    func didSelectItem(at indexPath: IndexPath) {
        //
    }
}
