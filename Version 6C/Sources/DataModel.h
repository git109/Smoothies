
@class Recipe;

/*
 * The top-level data model object for our app.
 */
@interface DataModel : NSObject
{
}

// Returns how many recipes are in the list.
- (int)recipeCount;

// Returns the Recipe object at the specified position in the list.
- (Recipe*)recipeAtIndex:(int)index;

// Deletes a Recipe object from the list.
- (void)removeRecipeAtIndex:(int)index;

// Returns the number of favorites.
- (int)favoritesCount;

// Returns the Recipe object at the specified position in the favorites list.
- (Recipe*)favoriteAtIndex:(int)index;

// Determines whether a Recipe is in the list of favorites.
- (BOOL)isFavorite:(Recipe*)recipe;

// Adds a Recipe to the favorites.
- (void)addToFavorites:(Recipe*)recipe;

// Removes a Recipe from the favorites.
- (void)removeFromFavorites:(Recipe*)recipe;

@end
