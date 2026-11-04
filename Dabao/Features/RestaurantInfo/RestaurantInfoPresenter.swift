import Foundation

@MainActor
final class RestaurantInfoPresenter: RestaurantInfoPresenterProtocol, RestaurantInfoInteractorOutputProtocol {

    weak var view: RestaurantInfoViewProtocol?
    private let interactor: RestaurantInfoInteractorInputProtocol
    private let router: RestaurantInfoRouterProtocol

    init(view: RestaurantInfoViewProtocol,
         interactor: RestaurantInfoInteractorInputProtocol,
         router: RestaurantInfoRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor.loadFacts()
    }

    func didTapDone() {
        router.close()
    }

    func didLoadFacts(_ facts: RestaurantFacts) {
        // TODO 3: Tell the view the title, and the rows to show.
        view?.showTitle(facts.name)
        view?.showRows(makeRows(from: facts))
    }

    func makeRows(from facts: RestaurantFacts) -> [InfoRowViewModel] {
        // TODO 4: Turn the facts into rows of text. The tests in
        // RestaurantInfoPresenterTests show some of the rows we expect, e.g.
        // "Status" / "Closed", and "Menu" / "6 dishes (1 sold out today)".

        var menuText = "\(facts.dishCount) dish"
        if facts.dishCount > 1 { menuText += "es" }
        if facts.soldOutCount > 0 {
            menuText += " (\(facts.soldOutCount) sold out today)"
        }

        return [
            InfoRowViewModel(
                title: "Status",
                value: facts.isOpen ? "Open now" : "Closed"
            ),
            InfoRowViewModel(
                title: "Menu",
                value: menuText
            ),
        ]
    }
}
