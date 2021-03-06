//
//  PageState.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

class PageState {
    private var currentPageIndex: Int
    let maxPageIndex: Int
    let itemsPerPage: Int

    init(
        initialPageIndex: Int,
        maxPageIndex: Int,
        itemsPerPage: Int
    ) {
        currentPageIndex = initialPageIndex
        self.maxPageIndex = maxPageIndex
        self.itemsPerPage = itemsPerPage
    }

    /**
     Returns *currentPageIndex* and increments it to the next index
     if and only if it's less than or equal to *maxPageIndex*
     */
    func returnThenIncrement() -> Int? {
        let toReturn = currentPageIndex
        if toReturn > maxPageIndex {
            return nil
        }
        currentPageIndex += 1
        return toReturn
    }
}
