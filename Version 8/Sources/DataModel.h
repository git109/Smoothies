
@class Recipe;

/*
 * Notification that is sent when the list of recipes is changed.
 */
extern NSString* const RecipesChangedNotification;

/*
 * Notification that is sent when the list of favorites is changed.
 */
extern NSString* const FavoritesChangedNotification;

/*
 * The top-level data model object for our app.
 */
@interface DataModel : NSObject
{
	int nextId;
	NSMutableArray* sortedFavorites;
}

// The favorites as a list of Recipe objects, sorted by name
@property (nonatomic, readonly, retain) NSArray* sortedFavorites;

// Returns how many recipes are in the list.
- (int)recipeCount;

// Returns the Recipe object at the specified position in the list.
- (Recipe*)recipeAtIndex:(int)index;

// Adds a Recipe to the end of the list.
- (void)addRecipe:(Recipe*)recipe;

// Deletes a Recipe object from the list.
- (void)removeRecipeAtIndex:(int)index;

// Call this to send out a notification that the Recipe has changed
- (void)didChangeRecipe:(Recipe*)recipe;

// Returns the number of favorites.
- (int)favoritesCount;

// Determines whether a Recipe is in the list of favorites.
- (BOOL)isFavorite:(Recipe*)recipe;

// Adds a Recipe to the favorites.
- (void)addToFavorites:(Recipe*)recipe;

// Removes a Recipe from the favorites.
- (void)removeFromFavorites:(Recipe*)recipe;

@end
