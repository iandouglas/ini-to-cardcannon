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
- a link to browse all items for sale ("/items")
- a link to see all merchants ("/merchants")
- a link to my shopping cart ("/cart")
- a link to log in ("/login")
- a link to the user registration page ("/register")
Next to the shopping cart link I see a count of the items in my cart
```

```
[ ] done

User Story 3
User Navigation

As a registered user
I see the same links as a visitor
Plus the following links
- a link to my profile page ("/profile")
- a link to see my orders ("/profile/orders")
- a link to log out ("/logout")
Minus the following links
- I do not see a link to log in or register
I also see text that says "Logged in as Ian Douglas" (or whatever my name is)
```

```
[ ] done

User Story 4
Merchant Navigation

As a merchant user
I see the same links as a registered user
Plus the following links:
- a link to my merchant dashboard ("/dashboard")
Minus the following links/info:
- a link to my shopping cart ("/cart")
- the count of the items in my cart
```

```
[ ] done

User Story 5
Admin Navigation

As an admin user
I see the same links as a registered user
Plus the following links
- a link to see all users ("/admin/users")
Minus the following links/info:
- a link to my shopping cart ("/cart")
- the count of the items in my cart
```

```
[ ] done

User Story 6
Users cannot navigate to certain paths

Users should see a 404 error under the following conditions:
- if visitors try to navigate to any /profile path
- if visitors try to navigate to any /dashboard path
- if visitors try to navigate to any /admin path
- if registered users try to navigate to any /dashboard path
- if registered users try to navigate to any /admin path
- if merchants try to navigate to any /profile path
- if merchants try to navigate to any /admin path
- if merchants try to navigate to any /cart path
- if admin users try to navigate to any /profile path
- if admin users try to navigate to any /dashboard path
- if admin users try to navigate to any /cart path
If you think of any additional pages to block, please do so.
```

---

## User Registration
This series of stories will allow a user to register on the site.

```
[ ] done

User Story 7
User Registration

As a visitor
When I click on the 'register' link in the nav bar
Then I am on the user registration page
And I see a form where I input the following data:
- my name
- my street address
- my city
- my state
- my zip code
- my email address
- my preferred password
- a confirmation field for my password
When I fill in this form completely,
And with a unique email address not already in the system
My details are saved in the database
Then I am logged in as a registered user
I am taken to my profile page ("/profile")
I see a flash message indicating that I am now registered and logged in
```

```
[ ] done

User Story 8
User Registration Missing Details

As a visitor
When I visit the user registration page
And I do not fill in this form completely,
I am returned to the registration page
And I see a flash message indicating that I am missing required fields
```

```
[ ] done

User Story 9
Registration Email must be unique

As a visitor
When I visit the user registration page
If I fill out the registration form
But include an email address already in the system
Then I am returned to the registration page
My details are not saved and I am not logged in
The form is filled in with all previous data except the email field and password fields
I see a flash message telling me the email address is already in use
```

---

## Login / Logout
Our application wouldn't be much use if users could not log in to use it.

```
[ ] done

User Story 10
User can Login

As a visitor
When I visit the login path
I see a field to enter my email address and password
When I submit valid information
If I am a regular user, I am redirected to my profile page
If I am a merchant user, I am redirected to my merchant dashboard page
If I am an admin user, I am redirected to the home page of the site
And I see a flash message that I am logged in
```

```
[ ] done

User Story 11
User cannot log in with bad credentials

As a visitor
When I visit the login page ("/login")
And I submit valid information
Then I am redirected to the login page
And I see a flash message that tells me that my credentials were incorrect
I am NOT told whether it was my email or password that was incorrect
```

```
[ ] done

User Story 12
Users who are logged in already are redirected

As a registered user, merchant, or admin
When I visit the login path
If I am a regular user, I am redirected to my profile page
If I am a merchant user, I am redirected to my merchant dashboard page
If I am an admin user, I am redirected to the home page of the site
And I see a flash message that tells me I am already logged in
```

```
[ ] done

User Story 13
User can log out

As a registered user, merchant, or admin
When I visit the logout path
I am redirected to the welcome / home page of the site
And I see a flash message that indicates I am logged out
Any items I had in my shopping cart are deleted
```

