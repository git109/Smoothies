
/*
 * Describes a recipe.
 */
@interface Recipe : NSObject
{
}

@property (nonatomic, assign) int recipeId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* instructions;
@property (nonatomic, retain) UIImage* image;

// Used to sort the list of Recipe objects by name
- (NSComparisonResult)compareName:(Recipe*)recipe;

@end
