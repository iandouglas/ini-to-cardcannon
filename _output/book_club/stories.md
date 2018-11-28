# Book Club
BE Mod 2 Week 2/3 Paired Project

## Background and Description

This purpose of this application is for users to browse and review books. The primary goals of this project are to test your ability to set up many-to-many relationships and accessing attributes through multiple model relationships.

## Learning Goals for this Project

- creation of a basic Rails web application
- implementing basic MVC structure to your project
- save and retrieve data from a database
- display content on a web page with some very basic styling
- learning how to test your code effectively at a Controller and a Model level

## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- all controller and model code must be tested via feature tests and model tests, respectively
- must use some amount of HTML and CSS layout
- must deploy project to Heroku


## Not Allowed

- ask instructors in your public channel before adding any additional gems to your project
- do not use JavaScript to sort content on a page


## User Stories

These user stories may be worked on in any order that makes sense to your team. The most optimal order may not be a top-to-bottom approach.

```
[ ] done

User Story 1
Deploy your application to Heroku

As a visitor or user of the site
I will perform all user stories
By visiting the application on Heroku.
Localhost is fine for development, but
the application must be hosted on Heroku.
```

---

## Navigation
This series of stories will set up a navigation bar at the top of the screen and present links and information to users of your site.

There is no requirement that the nav bar be "locked" to the top of the screen.

### Completion of these stories will encompass the following ideas:

- the navigation is built into app/views/layouts/application.html.erb or loaded into that file as a partial
- you write a single set of tests that simply click on a link and expect that your current path is what you expect to see
- your nav tests don't need to check any content on the pages, just that current_path is what you expect

You will need to set up some basic routing and empty controller actions and empty action view files.

```
[ ] done

User Story 2
Visitor Navigation

As a visitor
I see a navigation bar
This navigation bar includes links for the following:
- a link to return to the welcome / home page of the application ("/")
- a link to browse all books ("/books")
```

```
[ ] done

User Story 3
All book titles are links to a show page

As a visitor
With the exception of a book's show page,
Anywhere I see a book title on the site,
I can click on the book title to go to that book's show page.
```

```
[ ] done

User Story 4
All author names are links to a show page

As a visitor
With the exception of an author's show page,
Anywhere I see an author's name on the site,
I can click on the name to go to that author's show page.
```

```
[ ] done

User Story 5
All user names are links to a show page

As a visitor
With the exception of a user's show page,
Anywhere I see a user's name on the site for a book review,
I can click on the name to go to that user's show page.
```

---

## Book Index Page
This index page will be the primary page visited by users of the application.

Set up a minimum of 12 books to appear on this page.

```
[ ] done

User Story 6
Book Index Page

As a Visitor,
When I visit a book index page,
I see all book titles in the database.
Each book entry on the page shows the author(s) and number of
pages in the book, and the year it was published.
```

```
[ ] done

User Story 7
Book Index Page shows Average Rating

As a Visitor,
When I visit the book index page,
Next to each book title, I see its average book rating
And I also see the total number of reviews for the book.
```

```
[ ] done

User Story 8
Book Index Page can be Sorted

As a Visitor,
When I visit the book index page,
I should see one link each to sort the books by the following criteria:
- sorted by average rating in ascending order
- sorted by average rating in descending order
- sorted by number of pages in ascending order
- sorted by number of pages in descending order
- sorted by number of reviews in ascending order
- sorted by number of reviews in descending order
```

```
[ ] done

User Story 9
Book Index Page shows Statistics

As a Visitor,
As a Visitor,
When I visit the book index page,
I see an area showing statistics about all books:
- three of the highest-rated books (book title and rating score)
- three of the worst-rated books (book title and rating score)
- three users who have written the most reviews (user name and review count)
```

---

## Book Show Page
A book's "show" page will display information about a particular book.


```
[ ] done

User Story 10
Book Show Page

As a Visitor,
When I visit a book's show page,
I see the book title, the author(s) and the number of pages in the book.
I also see a list of reviews for that book.

Each review will have a title and user, a numeric rating
from 1 to 5, and text for the review itself, and all content
must be present for each review.
```

```
[ ] done

User Story 11
Book Show Page has Statistics

As a Visitor,
When I visit a book's show page,
I see an area on the page for statistics about reviews:
- the top three reviews for this book (title, rating and user only)
- the bottom three reviews for this book  (title, rating and user only)
- the overall average rating of all reviews for this book
```

---

## Adding New Content
Our application will need a way for users to input new books, and to leave reviews for books.


```
[ ] done

User Story 12
Add a New Book to the System

As a Visitor,
When I visit the book index page,
I see a link that allows me to add a new book.
When I click that link, I am taken to a new book path.
I can add a new book through a form, including the book's
title, author(s), and number of pages in the book.
When I submit the form, I am taken to that book's show page.

Book titles should be converted to Title Case before saving.
Book titles should be unique within the system.
For authors, a comma-separated list of names should be entered,
and each author will be added to the database.
Authors added to the database should have their names converted
to Title Case.
Author Names should be unique within the system.
```

```
[ ] done

User Story 13
Add a Review for a Book

As a Visitor,
When I visit a book's show page
I see a link to add a new review for this book.
When I click on this link, I am taken to a new review path.
On this new page, I see a form where I can enter:
- a review title
- my username as a string
- a numeric rating that can only be a number from 1 to 5
- some text for the review itself
When the form is submitted, I should return to that book's
show page and I should see my review text.

User names should be converted to Title Case before saving.
User names should be unique within the system.
```

---

## Author Show Page
This "show" page will display information about a specific author.


```
[ ] done

User Story 14
Author Show Page

As a Visitor,
When I visit an author's show page
I see all book titles by that author
Each book should show its year of publication
Each book should show its number of pages
Each book should show a list of any other authors
(exclude this show page's author from that list)
```

```
[ ] done

User Story 15
Author Show Page displays top review for each book

As a Visitor,
When I visit an author's show page,
Next to each book written by that author
I should see one of the highest rated reviews
(review should contain the title, score, and user name)
```

---

## User Show Page
This "show" page will display information about a visitor who has left reviews for books on our system.


```
[ ] done

User Story 16
User Show Page

As a Visitor,
When I click on a user's name for any book review
I am taken to a show page for that user.
I should see all reviews (title, rating and text) that this
user has written.
```

```
[ ] done

User Story 17
User Show Page can sort reviews

As a Visitor,
When I visit a user's show page
I should also see links to sort reviews in the following ways:
- sort reviews newest first (descending chronological order)
- sort reviews oldest first (ascending chronological order)
```

---

## Deleting Content
Visitors will have the ability to delete content in our application, such as reviews, books, and authors.


```
[ ] done

User Story 18
User can delete a book review

As a Visitor,
When I visit a user's show page,
I see a link next to each review to delete the review.
When I delete a review I am returned to the user's show page
Then I should no longer see that review.
```

```
[ ] done

User Story 19
User can delete a book

As a Visitor,
When I visit a book's show page,
I see a link on the page to delete the book.
This link should return me to the book index page where I
no longer see this book listed.

(your controller may need to delete other content before you can delete the book)
```

```
[ ] done

User Story 20
User can delete an author

As a Visitor,
When I visit an author's show page,
I see a link on the page to delete the author.
This link should return me to the book index page where I
no longer see this author listed.
If this author was the only author for any book, that book is also deleted.
If this author co-authored a book with someone else, that book should also be deleted, but not the other author.

(you may need to delete other content before you can delete an author or book)
```

---

## Extensions
If you finish the user stories above before the deadline, you are expected to attempt extension work. Extensions should not be attempted until all other work is complete.


```
[ ] done

User Story 21
User reviews are sortable

As a Visitor,
When I visit a user's show page to see their reviews,
I see additional links to sort their reviews in the following ways:
- sort reviews by highest rating, then by descending date
- sort reviews by lowest rating, then by ascending date
```

```
[ ] done

User Story 22
Review usernames are unique for a given book

As a Visitor,
I should not be permitted to save a book review using a name
I've previously used to review a specific book.

(user names are unique for a specific book's reviews)
```

```
[ ] done

User Story 23
Book Index Page statistics shows top authors

As a Visitor,
When I visit the book index page,
In the Statistics area of the page,
I should also see three authors who have the highest-rated books
(average rating of all books for that author)
```

```
[ ] done

User Story 24
Spend any extra time on HTML/CSS

As a Developer
I will spend additional time on HTML layout and CSS styling
to create a visually outstanding project
```

