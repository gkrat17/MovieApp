//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class MoviesViewController: UIViewController {
    var presenter: MoviesPresenter!

    @IBOutlet private weak var collectionView: UICollectionView!

    typealias MovieSummaryCell = DefaultCell<MovieSummaryView>

    static func getInstance() -> MoviesViewController {
        .init(nibName: className, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(MovieSummaryCell.self,
                                forCellWithReuseIdentifier: MovieSummaryCell.identifier)

        presenter.viewDidLoad()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension MoviesViewController: MoviesView {
    func show(error: String) {
        print(error)
    }

    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }

    func insertItems(at indexPaths: [IndexPath]) {
        collectionView.insertItems(at: indexPaths)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = MovieSummaryCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieSummaryCell
        let model = presenter.viewModel(at: indexPath)
        cell.content.configure(from: model)

        // check if load next page
        if indexPath.row == presenter.numberOfItems(in: indexPath.section) - 1 {
            DispatchQueue.main.async { [weak self] in // to quickly return the cell
                self?.presenter.scrolledToTheEnd()
            }
        }

        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    var collectionViewInset: CGFloat { 10 }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = collectionViewInset
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 120

        let device = UIDevice.current
        let orientation = device.orientation
        let idiom = device.userInterfaceIdiom

        if (orientation == .landscapeLeft || orientation == .landscapeRight) && idiom == .pad {
            width /= 2
        }
        width -= 2 * collectionViewInset

        return .init(width: width, height: height)
    }
}
