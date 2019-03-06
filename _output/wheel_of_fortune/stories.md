## Wheel of !Fortune

2 week paired project for FE Mod 2 (week 2-3)

## Background and Description
For this project you will learn object-oriented programming (OOP) principles by building the game Wheel of Fortune. This is an opportunity to work with classes to build a program at a larger scale than you have with previous projects. This is also an opportunity for you to build out a program based on user stories - which is more aligned to what you can expect to see working with product managers in a production environment.

Building software, at its core, is about solving problems. Generally speaking, the first step in finding a solution to the problem is to be sure that you have clearly identified the problem as well what features the solution must incorporate. From here, we can flesh out the requirements that specify what our program should have. For the problem of building Wheel of Fortune, the rules of this game will serve as the requirements for the spec.

## Goals and Objectives

- Write a program from scratch
- Design and implement OOP patterns
- Understand and implement ES6 classes
- Implement array iterator and mutator methods to work with game data
- Write modular, reusable code that follows SRP (Single Responsibility Principle)
- Create a robust test suite that thoroughly tests all functionality of a client-side application

## Restrictions

To populate your data for WOF, you will be using [this data](https://repl.it/@thatpamiam/WheelOfFortune). Copy this into a separate js file that you can include as a script tag in your HTML file.

You will be using the following JavaScript libraries:

- [jQuery](http://jquery.com/) (REQUIRED)
- [Mocha](http://mochajs.org/) (and Chai) (REQUIRED)
- Other libraries may be used only with instructor approval.

## Requirements
#### Initial Setup

For this project, you need to use this [Gametime Starter Kit](https://github.com/turingschool-examples/gametime-starter) repo. Follow the instructions in the README for forking the repo and getting it setup. Once you have it set up (through running `npm install`), follow the instructions to verify it is setup correctly.

There are additional notes in the README about where your game logic code goes and where your test code goes as well. Be sure to read through the README before you start coding because for this starter kit to work correctly, it has some underlying assumptions of where files live.

## Code Organization

You should have at least one use-case for [inheritance](https://www.sitepoint.com/understanding-ecmascript-6-class-inheritance/) with your classes.

- a parent class’s properties and methods should be shared by all the child classes
- a child class should inherit those properties and methods from the parent class
- a child class should add additional properties or methods, or override the functionality of a parent method
- each class should have its own file with the filename capitalized (e.g. `Level.js`). The class should be capitalized as well. Only code that is a part of this class should be in this file.

## Testing

You should be testing your the correctness of your code throughout your project. Each JavaScript file in your project should have its own test file. (e.g. Your Wheel.js class file should have a corresponding testing file called `Wheel-test.js`)

Your testing suite should test all of the functionality of the game, including the following:

- Class default properties
- Class methods
- Anything that updates class properties
- For the purposes of this project, you will keep your state logic completely separate from your view logic. In other words, your business logic (classes/methods) should not handle anything that deals with the UI (DOM Manipulation).

To do this, you will utilize a separate domUpdates.js file that handles any DOM manipulation that is triggered by your business logic. This is covered in more depth in the testing lesson, which you can find [here](http://frontend.turing.io/lessons/module-2/test-driven-development.html#dom-manipulation).

---

## Game Mechanics


```
[ ] done

User Story 1, Basic Game Mechanics

As a developer of the game,
I must allow 3 players to play the game,
and I must allow 4 rounds of play for all players,
plus one bonus round for the winner.
```

```
[ ] done

User Story 2, Game Mechanics, Puzzles

As a developer of the game,
I must generate a list of puzzle words (or phrases).
This list is called a "bank" of puzzles.
Each word/phrase has a category such as "phrase", "person", "things" etc
```

```
[ ] done

User Story 3, Game Mechanics, Wheels

As a developer of the game,
I need to be able to randomly generate a "wheel" for each round.
The wheel will have at least 6 prize sections.
Each section can be one of the following:

- positive dollar amount
- lose a turn
- bankruptcy

My wheel generator must be able to generate a "bonus round" wheel.
The "bonus" wheel only contains positive dollar amounts.
The dollar amounts are 10x larger than a regular wheel.
```

```
[ ] done

User Story 4, Beginning a Game

As a visitor,
When I visit the web page,
Then I see a button to start a new game.
Clicking this button starts a new game
Even if one was already in progress.
The game chooses at least one "bank" of puzzles.
```

```
[ ] done

User Story 5, Setting Up a New Game

As a visitor,
When I begin a new game,
All "game" scores are reset to 0,
And I am prompted to enter the names of three players.
The new game begins when I successfully enter three names.
I see scores of 0 next to each player's name
```

---

## Playing a Game Round


```
[ ] done

User Story 6, Playing a Round, Step 1

As a player of the game,
When a round begins,
A random puzzle word is chosen
A random wheel is generated
Each player is given a "round" score of $0
This score is not the same as their "game" score.
```

```
[ ] done

User Story 7, Playing a Round, Step 2

As a player of the game,
When a round begins,
The UI hides all letters of the puzzle word/phrase
The UI shows the category of the puzzle
The UI shows clear indications of letters/spaces in the word/phrase
```

```
[ ] done

User Story 8, Playing a Round, Step 3

As a player of the game,
Until the round is finished,
Each player is prompted to choose one of three actions:

- solve the puzzle
- spin the wheel
- buy a vowel

The UI should show an easy way to input this choice.
```

```
[ ] done

User Story 9, Playing a Round, Step 4

As a player of the game,
The UI updates to show all letters and vowels guessed during the round.
```

```
[ ] done

User Story 10, Buying a vowel

As a player of the game,
If I choose to buy a vowel,
The UI allows me to enter a choice.
My choices are A, E, I, O, U only.

If there are remaining vowels to guess
My "round" score is reduced by $100.
If I guess a vowel that was already chosen,
I get to guess again

If there are no remaining vowels to guess,
My "round" score is not reduced by $100
And my turn is over.
```

---

## Spinning the Wheel


```
[ ] done

User Story 11, Spin the Wheel, Step 1

As a player of the game,
If I choose to spin the wheel,
The UI will ... TODO
The section of the wheel I land on will determine my outcome.
```

```
[ ] done

User Story 12, Spin the Wheel, Losing a Turn

As a player of the game,
If I land on "Lose Your Turn" when I spin the wheel
Then my turn is over.
```

```
[ ] done

User Story 13, Spin the Wheel, Bankruptcy

As a player of the game,
If I land on "Bankruptcy" when I spin the wheel
Then my "round" score is reset to $0.
My "game" score is unaffected.
My turn is over.
```

```
[ ] done

User Story 14, Spin the Wheel, in a regular round, landing on money

As a player of the game,
If I land on a dollar amount when I spin the wheel
Then I am prompted by the UI to choose a consonant.
```

```
[ ] done

User Story 15, Spin the Wheel, choosing a valid consonant

As a player of the game,
When I choose a consonant,
If that consonant was previously chosen I am prompted to guess again.
If that consonant is a valid letter in the puzzle:

- each instance of that letter is revealed
- my "round" score increases by the money amount on the wheel multiplied
by the number of letters that were just revealed
NELWINE
My turn continues, and I can solve, buy a vowel, or spin the wheel again
```

```
[ ] done

User Story 16, Spin the Wheel, Choosing an invalid consonant

As a player of the game,
When I choose a consonant,
If that consonant is NOT a valid letter in the puzzle
Then my turn is over.
```

---

## Solving the Puzzle


```
[ ] done

User Story 17, Solving the Puzzle, Step 1

As a player of the game,
If I choose to solve the puzzle,
The UI will give me an input field where I type my guess
My guess should not have to be CaSe-SeNsItiVe to be correct.

If I do not solve the puzzle correctly, my turn is over.
```

```
[ ] done

User Story 18, Solving the Puzzle, Step 2

As a player of the game,
If I choose to solve the puzzle,
And I solve the puzzle correctly,
The round is over
Any money I've accumulated in this round is added to my "game" score.
Money accumulated by other players in this round is discarded.
```

---

## Solving the Puzzle


```
[ ] done

User Story 19, Solving the puzzle ends the round

As a developer of the game,
When a player successfully solves the puzzle,
All players see their accumulated "game" scores so far.
The UI prompts the user to start the next round.
If this was the 4th round, a game winner is declared
And a bonus round begins.
```

```
[ ] done

User Story 20, Picking a Winner

As a developer of the game,
When all 4 rounds have been finished,
The player with the highest accumulated "game" score is the winner.
```

```
[ ] done

User Story 21, Bonus Round, Part 1

As a player of the game,
If I am declared the winner,
A new bonus round is started where I am the only player who participates.
A new puzzle is chosen that contains at least 6 consonants.
A new "bonus" wheel is generated.
The UI shows the puzzle the same as the start of a regular round.
```

```
[ ] done

User Story 22, Bonus Round, Part 2

As the winning player of the game,
When the bonus round begins,
I spin the "bonus" wheel to select my prize.
```

```
[ ] done

User Story 23, Bonus Round, Part 3

As the winning player of the game,
When I have spun the "bonus wheel",
I am prompted to choose 1 vowel and 3 consonants.
The consonants cannot repeat, they must all be different.
Correct letter choices are revealed on the UI
No accumulated money is updated.
```

```
[ ] done

User Story 24, Bonus Round, Part 4

As the winning player of the game,
Once the UI reveals any correct letters,
I am prompted to solve the puzzle.
If I guess correctly, the prize is added to my "game" score
And the game is over.
My full accumulated "game" score is shown on the UI.
```

```
[ ] done

User Story 25, Bonus Round, Part 5

As the winning player of the game,
When I am prompted to solve the puzzle,
If I guess incorrectly, the puzzle is revealed.
No additional money is added to my "game" score.
The game is over.
My full accumulated "game" score is shown on the UI.
```

