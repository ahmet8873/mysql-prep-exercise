CREATE TABLE Recipe (
    RecipeID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

INSERT INTO Recipe (RecipeID, Name, CategoryID)
VALUES
    (1, 'Tofu Stir-Fry', 3),
    (2, 'Chocolate Cake', 2),
    (3, 'Teriyaki Chicken', 1);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

INSERT INTO Category (CategoryID, Name)
VALUES
    (1, 'Japanese'),
    (2, 'Cake'),
    (3, 'Vegetarian');


CREATE TABLE Ingredient (
    IngredientID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

INSERT INTO Ingredient (IngredientID, Name)
VALUES
    (1, 'Flour'),
    (2, 'Sugar'),
    (3, 'Eggs'),
    (4, 'Milk'),
    (5, 'Soy Sauce'),
    (6, 'Tofu'),
    (7, 'Chocolate');

CREATE TABLE RecipeIngredient (
    RecipeID INT,
    IngredientID INT,
    Quantity VARCHAR(50),
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID)
);

INSERT INTO RecipeIngredient (RecipeID, IngredientID, Quantity)
VALUES
    (1, 6, '200g'),
    (1, 7, '50g'),
    (1, 5, '2 tbsp'),
    (2, 1, '2 cups'),
    (2, 2, '1.5 cups'),
    (2, 3, '3'),
    (2, 4, '1 cup'),
    (2, 7, '100g'),
    (3, 5, '4 tbsp'),
    (3, 3, '4'),
    (3, 1, '2 cups');

CREATE TABLE Step (
    StepID INT PRIMARY KEY,
    Description VARCHAR(1000) NOT NULL
);

INSERT INTO Step (StepID, Description)
VALUES
    (1, 'Preheat the oven to 350°F.'),
    (2, 'Mix the flour and sugar together.'),
    (3, 'Add the eggs and milk to the mixture and stir well.'),
    (4, 'Pour the batter into a greased baking pan.'),
    (5, 'Bake in the preheated oven for 25-30 minutes.'),
    (6, 'Cut the tofu into small cubes.'),
    (7, 'Heat a pan and add soy sauce.'),
    (8, 'Add the tofu cubes and cook until they are browned.'),
    (9, 'Melt the chocolate in a double boiler.');

CREATE TABLE RecipeStep (
    RecipeID INT,
    StepID INT,
    StepNumber INT,
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID),
    FOREIGN KEY (StepID) REFERENCES Step(StepID)
);

INSERT INTO RecipeStep (RecipeID, StepID, StepNumber)
VALUES
    (1, 6, 1),
    (1, 7, 2),
    (1, 8, 3),
    (2, 1, 1),
    (2, 2, 2),
    (2, 3, 3),
    (2, 4, 4),
    (2, 5, 5),
    (2, 9, 6),
    (3, 7, 1),
    (3, 5, 2),
    (3, 6, 3),
    (3, 10, 4);

-- Primary Keys and Relationships:

-- The Recipe table has a primary key (RecipeID).
-- The Category table has a primary key (CategoryID).
-- The Ingredient table has a primary key (IngredientID).
-- The Step table has a primary key (StepID).

-- The relationships are as follows:

-- The Recipe table references the Category table with a foreign key (CategoryID).
-- The RecipeIngredient table references both the Recipe table and the Ingredient table with foreign keys (RecipeID and IngredientID).
-- The RecipeStep table references both the Recipe table and the Step table with foreign keys (RecipeID and StepID).


--Relationships:

-- One-to-Many: A Category can have multiple Recipes.
-- Many-to-Many: A Recipe can have multiple Ingredients, and an Ingredient can be used in multiple Recipes.
-- One-to-Many: A Recipe can have multiple Steps.

--All the vegetarian recipes with potatoes:
SELECT r.Name
FROM Recipe r
JOIN RecipeIngredient ri ON r.RecipeID = ri.RecipeID
JOIN Ingredient i ON ri.IngredientID = i.IngredientID
WHERE r.CategoryID = 3 
AND i.Name = 'Potatoes';


--All the cakes that do not need baking:
SELECT r.Name
FROM Recipe r
JOIN RecipeStep rs ON r.RecipeID = rs.RecipeID
JOIN Step s ON rs.StepID = s.StepID
WHERE r.CategoryID = 2 
AND s.Description NOT LIKE '%bake%';


--All the vegan and Japanese recipes:

SELECT r.Name
FROM Recipe r
JOIN Category c ON r.CategoryID = c.CategoryID
WHERE c.Name = 'Japanese'
AND NOT EXISTS (
    SELECT 1
    FROM RecipeIngredient ri
    JOIN Ingredient i ON ri.IngredientID = i.IngredientID
    WHERE ri.RecipeID = r.RecipeID
    AND i.Name IN ('Eggs', 'Milk')
);

--SELECT 1 in this context is just a way to structure the subquery to perform an existence check without retrieving any actual data.


--NORMALIZATION

--First Normal Form (1NF): in my database schema, all tables are  1NF since they don't contain any repeating groups, and each attribute has a single value.

--Second Normal Form (2NF):A table is in 2NF if it's in 1NF and all non-key attributes are fully functionally dependent on the entire primary key.

-- The Recipe table is in 2NF because it has a single-column primary key (RecipeID), and the other attributes (Name, CategoryID) depend on the entire primary key.
-- The Category table is also in 2NF because it has a single-column primary key (CategoryID), and the Name attribute depends on the entire primary key.
-- The Ingredient table is in 2NF because it has a single-column primary key (IngredientID), and the Name attribute depends on the entire primary key.
-- The Step table is in 2NF because it has a single-column primary key (StepID), and the Description attribute depends on the entire primary key.

--Third Normal Form (3NF): A table is in 3NF if it's in 2NF, and there are no transitive dependencies.



-- RecipeIngredient table: RecipeID and IngredientID together make up the primary key. There's no transitive dependency issue here.
-- RecipeStep table: RecipeID and StepID together make up the primary key. There's no transitive dependency issue here.

--Based on this analysis, my original database schema was already in 2NF and 3NF. There were no changes needed to normalize the database further.

--My database schema remains the same as what I provided, and it's in a well-normalized form. Each table has a clear primary key, and there are no transitive dependencies. Therefore, no changes were required to achieve normalization.
