
#import "Recipe.h"

@implementation Recipe

@synthesize name, instructions, image;

- (void)dealloc
{
	[name release];
	[instructions release];
	[image release];
	[super dealloc];
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"%@ %@", [super description], self.name];
}

@end
