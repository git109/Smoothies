
#import "Recipe.h"

@implementation Recipe

@synthesize recipeId, name, instructions, image;

- (void)dealloc
{
	[name release];
	[instructions release];
	[image release];
	[super dealloc];
}

- (NSComparisonResult)compareName:(Recipe*)recipe
{
	return [self.name localizedCaseInsensitiveCompare:recipe.name];
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"%@ ID: %d, Name: %@", [super description], self.recipeId, self.name];
}

@end
