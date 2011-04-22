
#import "DataModel.h"
#import "Recipe.h"

static NSString* const FAVORITES_KEY = @"Favorites";

NSString* const FavoritesChangedNotification = @"Smoothies-FavoritesChanged";

@interface DataModel ()

// The list of Recipe objects
@property (nonatomic, retain) NSMutableArray* recipes;

// The list of favorite Recipe objects
@property (nonatomic, retain) NSMutableArray* favorites;

@end

@implementation DataModel

@synthesize recipes, favorites;

- (id)init
{
	if ((self = [super init]))
	{
		// Create the recipe list object
		recipes = [[NSMutableArray arrayWithCapacity:10] retain];

		// And add a few recipes to it
		Recipe* recipe = [[Recipe alloc] init];
		recipe.name = @"Banana Shake";
		recipe.instructions = @"1 frozen banana\n1 fresh banana\ndollop of coconut milk\nhalf a glass of water\noptional: pinch of vanilla";
		recipe.image = [UIImage imageNamed:@"Banana Shake.png"];
		[recipes addObject:recipe];
		[recipe release];

		recipe = [[Recipe alloc] init];
		recipe.name = @"Green Smoothie";
		recipe.instructions = @"2 bananas\nhalf a glass of orange juice\nhandful of fresh spinach";
		recipe.image = [UIImage imageNamed:@"Green Smoothie.png"];
		[recipes addObject:recipe];
		[recipe release];

		recipe = [[Recipe alloc] init];
		recipe.name = @"Raspberry-Blueberry";
		recipe.instructions = @"1 banana\n125 gr frozen raspberries\n125 gr frozen blueberries\n1 glass soy milk\nhalf a glass of water";
		recipe.image = [UIImage imageNamed:@"Raspberry-Blueberry.png"];
		[recipes addObject:recipe];
		[recipe release];

		// Create the favorites list object
		NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:FAVORITES_KEY];
		favorites = [[NSMutableArray arrayWithArray:array] retain];
	}
	return self;
}

- (void)dealloc
{
	[recipes release];
	[favorites release];
	[super dealloc];
}

- (int)recipeCount
{
	return self.recipes.count;
}

- (Recipe*)recipeAtIndex:(int)index
{
	return [self.recipes objectAtIndex:index];
}

- (void)removeRecipeAtIndex:(int)index
{
	// Also remove the recipe from the list of favorites
	Recipe* recipe = [self recipeAtIndex:index];
	[self removeFromFavorites:recipe];

	[self.recipes removeObjectAtIndex:index];
}

- (Recipe*)findRecipeNamed:(NSString*)name
{
	for (Recipe* recipe in self.recipes)
	{
		if ([recipe.name isEqualToString:name])
			return recipe;
	}
	return nil;
}

- (int)favoritesCount
{
	return self.favorites.count;
}

- (Recipe*)favoriteAtIndex:(int)index
{
	NSString* name = [self.favorites objectAtIndex:index];
	return [self findRecipeNamed:name];
}

- (BOOL)isFavorite:(Recipe*)recipe
{
	return [self.favorites containsObject:recipe.name];
}

- (void)addToFavorites:(Recipe*)recipe
{
	[self.favorites addObject:recipe.name];

	// Sort the list by recipe name
	[self.favorites sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

	[[NSUserDefaults standardUserDefaults] setObject:self.favorites forKey:@"Favorites"];
	[[NSUserDefaults standardUserDefaults] synchronize];

	// Let any listeners know the list of favorites has changed
	[[NSNotificationCenter defaultCenter] postNotificationName:FavoritesChangedNotification object:self];
}

- (void)removeFromFavorites:(Recipe*)recipe
{
	[self.favorites removeObject:recipe.name];
	[[NSUserDefaults standardUserDefaults] setObject:self.favorites forKey:@"Favorites"];
	[[NSUserDefaults standardUserDefaults] synchronize];

	// Let any listeners know the list of favorites has changed
	[[NSNotificationCenter defaultCenter] postNotificationName:FavoritesChangedNotification object:self];
}

@end
