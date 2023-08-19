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
