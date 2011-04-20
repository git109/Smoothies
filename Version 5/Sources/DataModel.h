
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

@end
