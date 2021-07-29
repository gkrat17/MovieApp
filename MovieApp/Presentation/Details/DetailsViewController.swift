//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class DetailsViewController: UIViewController {
    var presenter: DetailsPresenter!

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var overviewTextLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    typealias SimilarMovieCell = DefaultCell<SimilarMovieView>

    static func getInstance() -> DetailsViewController {
        .init(nibName: className, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(SimilarMovieCell.self,
                                forCellWithReuseIdentifier: SimilarMovieCell.identifier)

        refreshScrollDirection()

        presenter.viewDidLoad()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        refreshScrollDirection()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    private func refreshScrollDirection() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = isCompact ? .horizontal : .vertical
    }

    private var isCompact: Bool {
        traitCollection.horizontalSizeClass == .compact &&
        traitCollection.verticalSizeClass != .compact
    }
}

extension DetailsViewController: DetailsView {
    func show(error: String) {
        print(error)
    }

    func updateDetails(from movie: Movie) {
        imageView.image = {
            if let image = movie.image {
                return UIImage(data: image)
            }
            return UIImage(named: "Movie")
        }()
        nameLabel.text = movie.name
        ratingLabel.text = "\(movie.averageRating)"
        overviewTextLabel.text = movie.overview
    }

    func insertItems(at indexPaths: [IndexPath]) {
        collectionView.insertItems(at: indexPaths)
    }

    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
}

extension DetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = SimilarMovieCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SimilarMovieCell
        let model = presenter.viewModel(at: indexPath)
        cell.content.confugure(from: model)

        // check if load next page
        if indexPath.row == presenter.numberOfItems(in: indexPath.section) - 1 {
            DispatchQueue.main.async { [weak self] in // to quickly return the cell
                self?.presenter.scrolledToTheEnd()
            }
        }

        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {

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
        return isCompact ? .init(width: 128, height: collectionView.frame.height) :
                           .init(width: collectionView.frame.width, height: 128)
    }
}
