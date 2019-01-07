# Little Shop of Orders, v2
BE Mod 2 Week 4/5 Group Project

## Background and Description

"Little Shop of Orders" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Merchant users can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped". Each user role will have access to some or all CRUD functionality for application models.

Students will be put into 3 or 4 person groups to complete the project.\n

## Learning Goals

- Advanced Rails routing (nested resources and namespacing)
- Advanced ActiveRecord for calculating statistics
- Average HTML/CSS layout and design for UX/UI
- Session management and use of POROs for shopping cart
- Authentication, Authorization, separation of user roles and permissions

## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- must use 'bcrypt' for authentication
- all controller and model code must be tested via feature tests and model tests, respectively
- must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool like waffle.io
- must include a thorough README to describe their project

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors first

## User Roles

1. Visitor - this type of user is anonymously browsing our site and is not logged in
2. Registered User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order
3. Merchant User - a registered user who is also has access to merchant data and operations; user is logged in to perform their work
4. Admin User - a registered user (but cannot also be a merchant) who has "superuser" access to all areas of the application; user is logged in to perform their work

## Order Status

1. 'pending' means a user has placed items in a cart and "checked out", merchants may or may not have fulfilled any items yet
3. 'shipped' means all merchants have fulfilled their items for the order, and has been shipped
4. 'cancelled' only 'pending' and 'processing' orders can be cancelled


## Not Everything can be FULLY Deleted

In the user stories, we talk about "CRUD" functionality. However, it's rare in a real production system to ever truly delete content, and instead we typically just 'enable' or 'disable' content. Users, items and orders can be 'enabled' or 'disabled' which blocks functionality (users whose accounts are disabled should not be allowed to log in, items which are disabled cannot be ordered, orders which are disabled cannot be processed, and so on).

Disabled content should also be restricted from showing up in the statistics pages. For example if a user is disabled they should not appear in a list of "users with most orders"; if an order is disabled it should not be considered as part of "top sales" and so on.

Be careful to watch out for which stories allow full deletion of content, and restrictions on when they apply.

```
[ ] done

User Story 1, Deploy your application to Heroku

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

User Story 2, Visitor Navigation

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

User Story 3, User Navigation

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

User Story 4, Merchant Navigation

As a merchant user
I see the same links as a visitor
Plus the following links:
- a link to my merchant dashboard ("/dashboard")
- a link to log out ("/logout")

Minus the following links/info:
- I do not see a link to log in or register
- a link to my shopping cart ("/cart") or count of cart items
```

```
[ ] done

User Story 5, Admin Navigation

As an admin user
I see the same links as a visitor
Plus the following links
- a link to see all users ("/admin/users")
- a link to my admin dashboard ("/admin/dashboard")
- a link to log out ("/logout")

Minus the following links/info:
- I do not see a link to log in or register
- a link to my shopping cart ("/cart") or count of cart items
```

```
[ ] done

User Story 6, Users cannot navigate to certain paths

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

User Story 7, User Registration

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

User Story 8, User Registration Missing Details

As a visitor
When I visit the user registration page
And I do not fill in this form completely,
I am returned to the registration page
And I see a flash message indicating that I am missing required fields
```

```
[ ] done

User Story 9, Registration Email must be unique

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

User Story 10, User can Login

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

User Story 11, User cannot log in with bad credentials

As a visitor
When I visit the login page ("/login")
And I submit valid information
Then I am redirected to the login page
And I see a flash message that tells me that my credentials were incorrect
I am NOT told whether it was my email or password that was incorrect
```

```
[ ] done

User Story 12, Users who are logged in already are redirected

As a registered user, merchant, or admin
When I visit the login path
If I am a regular user, I am redirected to my profile page
If I am a merchant user, I am redirected to my merchant dashboard page
If I am an admin user, I am redirected to the home page of the site
And I see a flash message that tells me I am already logged in
```

```
[ ] done

User Story 13, User can log out

As a registered user, merchant, or admin
When I visit the logout path
I am redirected to the welcome / home page of the site
And I see a flash message that indicates I am logged out
Any items I had in my shopping cart are deleted
```

---

## Items
This is the main "catalog" page of the entire site where users will start their e-commerce experience. Visitors to the site, and regular users, will be able to view an index page of all items available for purchase and some basic statistics. Each item will also have a "show" page where more information is shown.

```
[ ] done

User Story 14, Items Index Page

As any kind of user on the system
I can visit the items catalog ("/items")
I see all items in the system except disabled items
Each item will display the following information:
- the name of the item
- a small thumbnail image for the item
- the merchant name who sells the item
- how many of the item the merchant has in stock
- the merchant's current price for the item

The item name is a link to that item's show page
The item thumbnail is a link to that item's show page
```

```
[ ] done

User Story 15, Items Index Page Statistics

As any kind of user on the system
When I visit the items index page ("/items")
I see an area with statistics:
- the top 5 most popular items by quantity purchased, plus the quantity bought
- the bottom 5 least popular items, plus the quantity bought

"Popularity" is determined by total quantity of that item fulfilled
```

```
[ ] done

User Story 16, Item Show Page

As any kind of user on the system
When I visit an item's show page from the items catalog
My URI route is something like "/items/18"
I see all information for this item, including:
- the name of the item
- the description of the item
- a larger image of the item
- the merchant name who sells the item
- how many of the item the merchant has in stock
- the merchant's current price for the item
- an average amount of time it takes this merchant to fulfill this item

If I am a visitor or regular user, I also see a link to add this item to my cart
```

---

## User Profile Page
When a user who is not a merchant nor an admin logs into the system, they are taken to a profile page under a route of "/profile".

### Admins can act on behalf of users
Admin users can access a namespaced route of "/admin/users" to see an index page  of all non-merchant/non-admin users, and from there see each user. This will allow the admin to perform every action on a user's account that the user themselves can perform. Admin users can also "upgrade" a user account to become a merchant account.

```
[ ] done

User Story 17, User Profile Show Page

As a registered user
When I visit my own profile page
Then I see all of my profile data on the page except my password
And I see a link to edit my profile data
```

```
[ ] done

User Story 18, User Can Edit their Profile Data

As a registered user
When I visit my profile page
I see a link to edit my profile data
When I click on the link to edit my profile data
Then my current URI route is "/profile/edit"
I see a form like the registration page
The form contains all of my user information
The password fields are blank and can be left blank
I can change any or all of the information
When I submit the form
Then I am returned to my profile page
And I see a flash message telling me that my data is updated
And I see my updated information
```

```
[ ] done

User Story 19, User Editing Profile Data must have unique Email address

As a registered user
When I attempt to edit my profile data
If I try to change my email address to one that belongs to another user
When I submit the form
Then I am returned to the profile edit page
And I see a flash message telling me that email address is already in use
```

```
[ ] done

User Story 20, Admin User Profile Page

As an admin user
When I visit a user's profile page ("/admin/users/5")
I see the same information the user would see themselves
```

```
[ ] done

User Story 21, Admin can edit a user's profile data

As an admin user
When I visit a user's profile page ("/admin/users/5")
And I click the link to edit the user's profile data
The same behaviors exist as if I were that user trying to change their own data
Except I am returned to the show page path of
"/admin/users/5" when I am finished
```

```
[ ] done

User Story 22, Admin Sees User's Orders

As an admin user
When I visit a user's profile page
I see the same order data that the user sees
```

```
[ ] done

User Story 23, Admin can make a User a Merchant

As an admin user
When I visit a user's profile page ("/admin/users/5")
I see a link to "upgrade" the user's account to become a merchant
When I click on that link
I am redirected to ("/admin/merchants/5") because the user is now a merchant
And I see a flash message indicating the user has been upgraded
The next time this user logs in they are now a merchant
Only admins can see the "upgrade" link
Only admins can reach any route necessary to upgrade the user to merchant status
```

```
[ ] done

User Story 24, Admin is redirected from User profile to Merchant dashboard

As an admin user
If I visit a profile page for a user, but that user is a merchant
Then I am redirected to the appropriate merchant dashboard page.
eg, if I visit "/admin/users/7" but that user is a merchant
Then I am redirected to "/admin/merchants/7"
And I see their merchant dashboard page
```

---

## Shopping Cart and Checkout
This is what this app is all about: how a user can put things in a shopping cart and check out, creating an order in the process.

### Visitors and Regular Users only
Merchants and Admin users cannot order items. This will cause a conflict in the project if an admin upgrades a user to a merchant and that user had previous orders of their own. We're not going to worry about this conflict.

```
[ ] done

User Story 25, User adds an item to the cart

As a visitor or registered user
When I visit an item's show page from the items catalog
I see a link or button to add this item to my cart
And I click its link or button
I am returned to the item index page
I see a flash message indicating the item has been added to my cart
The navigation bar increments my cart counter
```

```
[ ] done

User Story 26, User views their cart show page with items in the cart

As a visitor or registered user
When I have added items to my cart
And I visit my cart ("/cart")
I see all items I've added to my cart
And I see a link to empty my cart
Each item in my cart shows the following information:
- the name of the item
- a very small thumbnail image of the item
- the merchant I'm buying this item from
- the price of the item
- my desired quantity of the item
- a subtotal (price multiplied by quantity)

I also see a grand total of what everything in my cart will cost
```

```
[ ] done

User Story 27, User views their cart show page but it's empty

As a visitor or registered user
When I add NO items to my cart yet
And I visit my cart ("/cart")
I see a message that my cart is empty
I do NOT see the link to empty my cart
```

```
[ ] done

User Story 28, User can empty a cart that has items

As a visitor or registered user
When I have items in my cart
And I visit my cart ("/cart")
And I click the link to empty my cart
Then I am returned to my cart
All items have been completely removed from my cart
The navigation bar shows 0 items in my cart
```

```
[ ] done

User Story 29, User can manipulate quantities in their cart

As a visitor or registered user
When I have items in my cart
And I visit my cart
Next to each item in my cart
I see a button or link to remove that item from my cart
- clicking this button will remove the item but not other items

I see a button or link to increment the count of items I want to purchase
- I cannot increment the count beyond the merchant's inventory size

I see a button or link to decrement the count of items I want to purchase
- If I decrement the count to 0 the item is immediately removed from my cart
```

```
[ ] done

User Story 30, Visitors must register or log in to check out

As a visitor
When I have items in my cart
And I visit my cart
I see information telling me I must register or log in to finish the checkout process
The word "register" is a link to the registration page
The words "log in" is a link to the login page
```

```
[ ] done

User Story 31, Registered users can check out

As a registered user
When I add items to my cart
And I visit my cart
I see a button or link indicating that I can check out
And I click the button or link to check out
An order is created in the system, which has a status of "pending"
I am taken to my orders page ("/profile")
I see a flash message telling me my order was created
I see my new order listed on my profile orders page
My cart is now empty
```

---

## User Order Show Page
The show page template for an order can be shared between users, merchants and admins to DRY up our presentation logic. They will operate through separate controllers, though.

### User Control
- Users can cancel an order if at least one item in the order is NOT yet fulfilled
- When an order is cancelled, any fulfilled items have their inventory returned to their respective merchants

### Merchant Control
- Merchants only see items in the order that are sold by that merchant
- Items from other merchants are hidden

### Admin Control
- Admins can cancel an order on behalf of a user
- Admins can fulfill items on order on behalf of a merchant

```
[ ] done

User Story 32, User Profile displays Orders link

As a registered user
When I visit my Profile page
And I have orders placed in the system
Then I see a link to my Profile Orders page

This link is also in the nav bar, but this new link is for admins.
```

```
[ ] done

User Story 33, User Profile displays Orders

As a registered user
When I visit my Profile Orders page, "/profile/orders"
I see every order I've made, which includes the following information:
- the ID of the order, which is a link to the order show page
- the date the order was made
- the date the order was last updated
- the current status of the order
- the total quantity of items in the order
- the grand total of all items for that order
```

```
[ ] done

User Story 34, User views an Order Show Page

As a registered user
When I visit my Profile Orders page
And I click on a link for order's show page
My URL route is now something like "/profile/orders/15"
I see all information about the order, including the following information:
- the ID of the order
- the date the order was made
- the date the order was last updated
- the current status of the order
- each item I ordered, including name, description, thumbnail, quantity, price and subtotal
- the total quantity of items in the whole order
- the grand total of all items for that order
```

```
[ ] done

User Story 35, Admin views a User's Order Show Page

As an admin user
When I visit a user's profile
And I click on a link for order's show page
My URL route is now something like "/admin/orders/15"
I see all information about the order, including the following information:
- the ID of the order
- the date the order was made
- the date the order was last updated
- the current status of the order
- each item the user ordered, including name, description, thumbnail, quantity, price and subtotal
- the total quantity of items in the whole order
- the grand total of all items for that order
```

```
[ ] done

User Story 36, User cancels an order

As a registered user
When I visit an order's show page
If the order is still "pending", I see a button or link to cancel the order
When I click the cancel button for an order, the following happens:
- Each row in the "order items" table is given a status of "unfulfilled"
- The order itself is given a status of "cancelled"
- Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
- I am returned to my profile page
- I see a flash message telling me the order is now cancelled
- And I see that this order now has an updated status of "cancelled"
```

```
[ ] done

User Story 37, Admin cancels a user's order

As an admin user
When I visit a user's order show page
If the order is still "pending", I see a button or link to cancel the order
When I click the cancel button for an order
The same behaviors happen as if the user canceled the order themselves
```

```
[ ] done

User Story 38, All Merchants fulfill items on an order

When all items in an order have been "fulfilled" by their merchants
The order status changes from "pending" to "shipped"
```

---

## Merchant Dashboard
This is the landing page when a merchant logs in. Here, they will see their contact information (but cannot change it), some statistics, and a list of pending orders that require the merchant's attention.

### Admins can act on behalf of merchants
Admin users will see more information on the "/merchants" route that all users see. For example, on this page, an admin user can navigate to each merchant's dashboard under a route like "/admin/merchants/7". This will allow the admin to perform every action that the merchant themselves can perform. Admin users can also "downgrade" a merchant account to become a user account.

```
[ ] done

User Story 39, Merchant Dashboard Show Page

As a merchant user
When I visit my dashboard ("/dashboard")
I see my profile data, but cannot edit it
```

```
[ ] done

User Story 40, Merchant Dashboard displays Orders

As a merchant
When I visit my dashboard ("/dashboard")
If any users have pending orders containing items I sell
Then I see a list of these orders.
Each order listed includes the following information:
- the ID of the order, which is a link to the order show page ("/dashboard/orders/15")
- the date the order was made
- the total quantity of my items in the order
- the total value of my items for that order
```

```
[ ] done

User Story 41, Merchant Dashboard Statistics

As a merchant
When I visit my dashboard, I see an area with statistics:
- top 5 items I have sold by quantity, and the quantity of each that I've sold
- total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory (eg, if I have sold 1,000 things and still have 9,000 things in inventory, the message would say something like "Sold 1,000 items, which is 10% of your total inventory")
- top 3 states where my items were shipped, and their quantities
- top 3 city/state where my items were shipped, and their quantities (Springfield, MI should not be grouped with Springfield, CO)
- name of the user with the most orders from me (pick one if there's a tie), and number of orders
- name of the user who bought the most total items from me (pick one if there's a tie), and the total quantity
- top 3 users who have spent the most money on my items, and the total amount they've spent
```

```
[ ] done

User Story 42, Merchant's Items index page

As a merchant
When I visit my dashboard
I see a link to view my own items
When I click that link
My URI route should be "/dashboard/items"
```

```
[ ] done

User Story 43, Admin can see a merchant's dashboard

As an admin user
When I visit the merchant index page ("/merchants")
And I click on a merchant's name,
Then my URI route should be ("/admin/merchants/6")
Then I see everything that merchant would see
```

```
[ ] done

User Story 44, Admin can downgrade a merchant to regular user

As an admin user
When I visit a merchant's dashboard ("/admin/merchants/6")
I see a link to "downgrade" the merchant's account to become a regular user
The merchant themselves do NOT see this link
When I click on that link
I am redirected to ("/admin/users/6") because the merchant is now a regular user
And I see a flash message indicating the user has been downgraded
The next time this user logs in they are no longer a merchant
All items for sale by this user are disabled
Only admins can see the "downgrade" button
Only admins can reach any route necessary to downgrade the merchant to user status
```

```
[ ] done

User Story 45, Admin is redirected from Merchant Dashboard to User profile

As an admin user
If I visit a merchant dashboard, but that merchant is a regular user
Then I am redirected to the appropriate user profile page.

eg, if I visit "/admin/merchants/7" but that merchant is a regular user
then I am redirected to "/admin/users/7" and see their user profile page
```

---

## Merchant Index Page
All users can see a merchant index page at "/merchants" which will list some basic information about each merchant. When admins visit this page, however, more functionality is found.

```
[ ] done

User Story 46, Merchant Index Page

As a visitor
When I visit the merchant's index page at "/merchants"
I see all merchants in the system who are active
Next to each merchant's name I see their city and state
I also see the date they registered
```

```
[ ] done

User Story 47, Merchant Index Page Statistics

As a visitor
When I visit the merchants index page, I see an area with statistics:
- top 3 merchants who have sold the most by price and quantity, and their revenue
- top 3 merchants who were fastest at fulfilling items in an order, and their times
- worst 3 merchants who were slowest at fulfilling items in an order, and their times
- top 3 states where any orders were shipped (by number of orders), and count of orders
- top 3 cities where any orders were shipped (by number of orders, also Springfield, MI should not be grouped with Springfield, CO), and the count of orders
- top 3 biggest orders by quantity of items shipped in an order, plus their quantities
```

```
[ ] done

User Story 48, Admin visits Merchant Index Page

As an admin user
When I visit the merchant's index page at "/merchants"
I see all merchants in the system
Next to each merchant's name I see their city and state
The merchant's name is a link to their Merchant Dashboard at routes such as "/admin/merchants/5"
I see a "disable" button next to any merchants who are not yet disabled
I see an "enable" button next to any merchants whose accounts are disabled
```

```
[ ] done

User Story 49, Admin disables a merchant account

As an admin merchant
When I visit the merchant index page
And I click on a "disable" button for an enabled merchant
I am returned to the admin's merchant index page
And I see a flash message that the merchant's account is now disabled
And I see that the merchant's account is now disabled
This merchant cannot log in
```

```
[ ] done

User Story 50, Admin enables a merchant account

As an admin merchant
When I visit the merchant index page
And I click on a "enable" button for a disabled merchant
I am returned to the admin's merchant index page
And I see a flash message that the merchant's account is now enabled
And I see that the merchant's account is now enabled
This merchant can now log in
```

---

## Merchant Items
Merchants need CRUD functionality for items in the database. These stories will work through the management of items. These routes should be namespaced like "/dashboard/items" and "/dashboard/items/6" and so on. Merchants can disable items so they are no longer for sale but stay in the database so orders are still handled properly. Merchants can fully delete items if nobody has ever ordered it.

### Admin functionality
Admin users share all management functionality, but the routes will be much longer, like "/admin/merchants/8/items" and "/admin/merchants/8/items/6" and so on.

```
[ ] done

User Story 51, Merchant Items Index Page

As a merchant
When I visit my items page "/dashboard/items"
I see a link to add a new item to the system
I see each item I have already added to the system, including:
- the ID of the item
- the name of the item
- a thumbnail image for that item
- the price of that item
- my current inventory count for that item
- a link or button to edit the item

If no user has ever ordered this item, I see a link to delete the item
If the item is enabled, I see a button or link to disable the item
If the item is disabled, I see a button or link to enable the item
```

```
[ ] done

User Story 52, Merchant disables an item

As a merchant
When I visit my items page
And I click on a "disable" button or link for an item
I am returned to my items page
I see a flash message indicating this item is no longer for sale
I see the item is now disabled
```

```
[ ] done

User Story 53, Merchant enables an item

As a merchant
When I visit my items page
And I click on an "enable" button or link for an item
I am returned to my items page
I see a flash message indicating this item is now available for sale
I see the item is now enabled
```

```
[ ] done

User Story 54, Merchant deletes an item

As a merchant
When I visit my items page
And I click on a "delete" button or link for an item
I am returned to my items page
I see a flash message indicating this item is now deleted
I no longer see this item on the page
```

```
[ ] done

User Story 55, Merchant adds an item

As a merchant
When I visit my items page
And I click on the link to add a new item
My URI route should be "/dashboard/items/new"
I see a form where I can add new information about an item, including:
- the name of the item, which cannot be blank
- a description for the item, which cannot be blank
- a thumbnail image URL string, which CAN be left blank
- a price which must be greater than $0.00
- my current inventory count of this item which is 0 or greater

When I submit valid information and save the form
I am taken back to my items page
I see a flash message indicating my new item is saved
I see the new item on the page, and it is enabled and available for sale
If I left the image field blank, I see a placeholder image for the thumbnail
```

```
[ ] done

User Story 56, Merchant cannot add an item if details are bad/missing

As a merchant
When I try to add a new item
If any of my data is incorrect or missing (except image)
Then I am returned to the form
I see one or more flash messages indicating each error I caused
All fields are re-populated with my previous data
```

```
[ ] done

User Story 57, Merchant edits an item

As a merchant
When I visit my items page
And I click the edit button or link next to any item
Then I am taken to a form similar to the 'new item' form
My URI route will be "/dashboard/items/15/edit" (if the item's ID was 15)
The form is re-populated with all of this item's information
I can change any information, but all of the rules for adding a new item still apply:
- name and description cannot be blank
- price cannot be less than $0.00
- inventory must be 0 or greater

When I submit the form
I am taken back to my items page
I see a flash message indicating my item is updated
I see the item's new information on the page, and it maintains its previous enabled/disabled state
If I left the image field blank, I see a placeholder image for the thumbnail
```

```
[ ] done

User Story 58, Merchant cannot edit an item if details are bad/missing

As a merchant
When I try to edit an existing item
If any of my data is incorrect or missing (except image)
Then I am returned to the form
I see one or more flash messages indicating each error I caused
All fields are re-populated with my previous data
```

```
[ ] done

User Story 59, Admin can manage items on behalf of a merchant

As an admin user
When I visit a merchant's profile page
I can click on the merchant's items link
And have access to all functionality the merchant does, including
- adding new items
- editing existing items
- enabling/disabling/deleting items

All content rules still apply (eg, item name cannot be blank, etc)
```

---

## Merchant Order Fulfillment
Merchants must "fulfill" each ordered item for users. They will visit an order show page which will allow them to mark each item as fulfilled. Once every merchant marks their items for an order as "fulfilled" then the whole order switches its status to "shipped". Merchants cannot fulfill items in an order if they do not have enough inventory in stock. If a user cancels an order after a merchant has fulfilled an item, the quantity of that item is returned to the merchant.

### Admin functionality
Admins can fulfill items in an order on behalf of a merchant.

```
[ ] done

User Story 60, Merchant sees an order show page

As a merchant
When I visit an order show page from my dashboard
I see the customer's name and address
I only the items in the order that are being purchased from my inventory
I do not see any items in the order being purchased from other merchants
For each item, I see the following information:
- the name of the item, which is a link to my item's show page
- a small thumbnail of the item
- my price for the item
- the quantity the user wants to purchase
```

```
[ ] done

User Story 61, Merchant fulfills part of an order

As a merchant
When I visit an order show page from my dashboard
For each item of mine in the order
If the user's desired quantity is equal to or less than my current inventory quantity for that item
And I have not already "fulfilled" that item:
- Then I see a button or link to "fulfill" that item
- When I click on that link or button I am returned to the order show page
- I see the item is now fulfilled
- I also see a flash message indicating that I have fulfilled that item
- My inventory quantity is permanently reduced by the user's desired quantity

If I have already fulfilled this item, I see text indicating such.
```

```
[ ] done

User Story 62, Merchant cannot fulfill an order due to lack of inventory

As a merchant
When I visit an order show page from my dashboard
For each item of mine in the order
If the user's desired quantity is greater than my current inventory quantity for that item
Then I do not see a "fulfill" button or link
Instead I see a big red notice next to the item indicating I cannot fulfill this item
```

```
[ ] done

User Story 63, Admin can fulfill order items on behalf of a merchant

As a merchant
When I visit an order show page from my dashboard
For each item of mine in the order
If the user's desired quantity is greater than my current inventory quantity for that item
Then I do not see a "fulfill" button or link
Instead I see a big red notice next to the item indicating I cannot fulfill this item
```

---

## Admin's User Index Page
The index page indicated in these stories should be namespaced under a route "/admin/users". This route should only be accessible to admin users of your application. Any functionality mentioned in this epic should be performed by admin users only, and respective routes should all be namespaced under "/admin"

```
[ ] done

User Story 64, Admin User Index Page

As an admin user
When I click on the "Users" link in the nav
Then my current URI route is "/admin/users"
And I see all users in the system who are not merchants nor admins
Each user's name is a link to a show page for that user ("/admin/users/5")
Next to each user's name is the date they registered
I see a "disable" button next to any users who are not yet disabled
I see an "enable" button next to any users whose accounts are disabled
```

```
[ ] done

User Story 65, Admin disables a user account

As an admin user
When I visit the user index page
And I click on a "disable" button for an enabled user
I am returned to the admin's user index page
And I see a flash message that the user's account is now disabled
And I see that the user's account is now disabled
This user cannot log in
```

```
[ ] done

User Story 66, Admin enables a user account

As an admin user
When I visit the user index page
And I click on a "enable" button for a disabled user
I am returned to the admin's user index page
And I see a flash message that the user's account is now enabled
And I see that the user's account is now enabled
This user can now log in
```

