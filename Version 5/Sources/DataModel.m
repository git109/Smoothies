
#import "DataModel.h"
#import "Recipe.h"

@interface DataModel ()

// The list of Recipe objects
@property (nonatomic, retain) NSMutableArray* recipes;

@end

@implementation DataModel

@synthesize recipes;

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
	}
	return self;
}

- (void)dealloc
{
	[recipes release];
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
	[self.recipes removeObjectAtIndex:index];
}

@end
