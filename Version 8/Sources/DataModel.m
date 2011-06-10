
#import "DataModel.h"
#import "Recipe.h"

static NSString* const FAVORITES_KEY = @"Favorites2";

NSString* const RecipesChangedNotification = @"Smoothies-RecipesChanged";
NSString* const FavoritesChangedNotification = @"Smoothies-FavoritesChanged";

@interface DataModel ()

// The list of Recipe objects
@property (nonatomic, retain) NSMutableArray* recipes;

// The list of favorite Recipe objects
@property (nonatomic, retain) NSMutableArray* favorites;

// We re-declare the property here to make it read-write instead of read-only
@property (nonatomic, retain) NSArray* sortedFavorites;

- (void)loadRecipes;
- (Recipe*)findRecipeWithId:(int)recipeId;
- (void)loadFavorites;
- (void)saveFavorites;

@end

@implementation DataModel

@synthesize recipes, favorites, sortedFavorites;

- (id)init
{
	if ((self = [super init]))
	{
		[self loadRecipes];
		[self loadFavorites];
	}
	return self;
}

- (void)dealloc
{
	[recipes release];
	[favorites release];
	[sortedFavorites release];
	[super dealloc];
}

- (void)loadRecipes
{
	// Create the recipe list object
	recipes = [[NSMutableArray arrayWithCapacity:10] retain];

	// And add a few recipes to it
	Recipe* recipe = [[Recipe alloc] init];
	recipe.recipeId = 1;
	recipe.name = @"Banana Shake";
	recipe.instructions = @"1 frozen banana\n1 fresh banana\ndollop of coconut milk\nhalf a glass of water\noptional: pinch of vanilla";
	recipe.image = [UIImage imageNamed:@"Banana Shake.png"];
	[recipes addObject:recipe];
	[recipe release];

	recipe = [[Recipe alloc] init];
	recipe.recipeId = 2;
	recipe.name = @"Green Smoothie";
	recipe.instructions = @"2 bananas\nhalf a glass of orange juice\nhandful of fresh spinach";
	recipe.image = [UIImage imageNamed:@"Green Smoothie.png"];
	[recipes addObject:recipe];
	[recipe release];

	recipe = [[Recipe alloc] init];
	recipe.recipeId = 3;
	recipe.name = @"Raspberry-Blueberry";
	recipe.instructions = @"1 banana\n125 gr frozen raspberries\n125 gr frozen blueberries\n1 glass soy milk\nhalf a glass of water";
	recipe.image = [UIImage imageNamed:@"Raspberry-Blueberry.png"];
	[recipes addObject:recipe];
	[recipe release];

	// When the user adds a new recipe, this is the ID it will get. It is
	// hardcoded here, but if we were actually loading the recipes from a
	// file, we would determine what the highest recipeId was and then set
	// nextId one higher.
	nextId = 4;
}

- (int)recipeCount
{
	return self.recipes.count;
}

- (Recipe*)recipeAtIndex:(int)index
{
	return [self.recipes objectAtIndex:index];
}

- (void)addRecipe:(Recipe*)recipe
{
	recipe.recipeId = nextId++;
	[self.recipes addObject:recipe];
}

- (void)removeRecipeAtIndex:(int)index
{
	// Also remove the recipe from the list of favorites
	Recipe* recipe = [self recipeAtIndex:index];
	[self removeFromFavorites:recipe];

	[self.recipes removeObjectAtIndex:index];
}

- (void)didChangeRecipe:(Recipe*)recipe
{
	[[NSNotificationCenter defaultCenter] postNotificationName:RecipesChangedNotification object:self];

	// If the name of the recipe was changed, the sort order of the favorites
	// list may be wrong, so we reload the list of favorites as well.
	self.sortedFavorites = nil;
	[[NSNotificationCenter defaultCenter] postNotificationName:FavoritesChangedNotification object:self];
}

- (Recipe*)findRecipeWithId:(int)recipeId
{
	for (Recipe* recipe in self.recipes)
	{
		if (recipe.recipeId == recipeId)
			return recipe;
	}
	return nil;
}

- (void)loadFavorites
{
	// Create the favorites list object
	NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:FAVORITES_KEY];
	self.favorites = [NSMutableArray arrayWithCapacity:array.count];
	for (NSNumber* number in array)
	{
		int recipeId = [number intValue];
		if ([self findRecipeWithId:recipeId] != nil)
			[self.favorites addObject:number];
	}
}

- (void)saveFavorites
{
	[[NSUserDefaults standardUserDefaults] setObject:self.favorites forKey:FAVORITES_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)favoritesCount
{
	return self.sortedFavorites.count;
}

- (NSArray*)sortedFavorites
{
	if (sortedFavorites == nil)  // lazy loading
	{
		// Add the Recipe objects to a new list
		self.sortedFavorites = [NSMutableArray arrayWithCapacity:favorites.count];
		for (NSNumber* number in self.favorites)
		{
			int recipeId = [number intValue];
			Recipe* recipe = [self findRecipeWithId:recipeId];
			if (recipe != nil)
			{
				[sortedFavorites addObject:recipe];
			}
		}

		// Sort the list by last name
		[sortedFavorites sortUsingSelector:@selector(compareName:)];
	}
	return sortedFavorites;
}

- (BOOL)isFavorite:(Recipe*)recipe
{
	return [self.favorites containsObject:[NSNumber numberWithInt:recipe.recipeId]];
}

- (void)addToFavorites:(Recipe*)recipe
{
	// Add the recipe's ID to the favorites list
	[self.favorites addObject:[NSNumber numberWithInt:recipe.recipeId]];

	// Save the favorites to NSUserDefaults
	[self saveFavorites];

	// We release the old sorted list and set it to nil. The next time anyone
	// asks for it, it will be re-created from scratch.
	self.sortedFavorites = nil;

	// Let any listeners know the list of favorites has changed
	[[NSNotificationCenter defaultCenter] postNotificationName:FavoritesChangedNotification object:self];
}

- (void)removeFromFavorites:(Recipe*)recipe
{
	[self.favorites removeObject:[NSNumber numberWithInt:recipe.recipeId]];
	[self saveFavorites];
	self.sortedFavorites = nil;
	[[NSNotificationCenter defaultCenter] postNotificationName:FavoritesChangedNotification object:self];
}

@end
