import Foundation

@MainActor
final class RestaurantInfoInteractor: RestaurantInfoInteractorInputProtocol {

    weak var output: RestaurantInfoInteractorOutputProtocol?
    private let restaurant: Restaurant

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    func loadFacts() {
        // TODO 2: Work out the facts about `restaurant`, put them in a `RestaurantFacts`,
        // and send them to the presenter through `output`.
        // Hint: `filter` and `count` will help with the sold-out and spicy counts.

        let soldOutCount = restaurant.menu.filter { $0.isSoldOut == true }.count
        let spicyCount = restaurant.menu.filter { $0.isSpicy == true }.count

        let facts: RestaurantFacts = RestaurantFacts(
            name: restaurant.name,
            cuisine: restaurant.cuisine,
            rating: restaurant.rating,
            deliveryMinutes: restaurant.deliveryMinutes,
            deliveryFee: restaurant.deliveryFee,
            isOpen: restaurant.isOpen,
            dishCount: restaurant.menu.count,
            soldOutCount: soldOutCount,
            spicyCount: spicyCount
        )

        output?.didLoadFacts(facts)
    }
}
