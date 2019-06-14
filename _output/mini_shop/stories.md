# MiniShop
BE Mod 2 Week 1 Solo Project

## Learning Goals

### Rails

* Implement CRUD functionality for a resource using forms (form_tag or form_for), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Create routes for
* standalone resources
* nested resources
* Template a view in Rails using a templating language (eg, `erb`)
* Implement CRUD functionality for nested resources

### ActiveRecord

* Create instance methods on a Rails model that use ActiveRecord associations
* Use built-in ActiveRecord methods to:
* create, read, update, and destroy records in a database
* create records with relationships to other records in a database

### Databases

* Describe Database Relationships, including the following terms:
* Primary Key
* Foreign Key
* One to Many
* Write migrations to create tables and relationships between tables
* Describe ORMs and their advantages and use cases

### Testing and Debugging

* Write feature tests utilizing:
* RSpec and Capybara
* CSS selectors to target specific areas of a page
* Use Pry or Byebug in Rails files to get more information about an error
* Use `save_and_open_page` to view the HTML generated when visiting a path in a feature test
* Utilize the Rails console as a tool to get more information about the current state of a development database
* Use `rails routes` to get additional information about the routes that exist in a Rails application

### Styling

* Create basic Web Pages using the following tags
* `<h1>`, `<h2>`, etc.
* `<p>`
* `<body>`
* `<a>` and the `href` attribute
* `<img>` and the `src` attribute
* `<div>`
* `<section>`
* `<ul>`, `<ol>`, and `<li>`
* `<form>`
* `<input>`
* Select HTML elements using classes and ids

### Web Applications

* Describe the HTTP request/response cycle
* Describe the different parts of HTTP requests and responses

## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- must "handroll" all routes (no use of `resources` syntax)
- must use `form_tag` for all forms (no use of `form_for`)

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors firs

---

## Merchants
Merchants are organizations/companies who sell items on our site (as opposed to individual people/users)

```
[ ] done

User Story 1, Merchant Index

As a visitor
When I visit '/merchants'
Then I see the name of each merchant in the system
```

```
[ ] done

User Story 2, Merchant Show

As a visitor
When I visit '/merchants/:id'
Then I see the merchant with that id including the merchant's:
- name
- address
- city
- state
- zip
```

```
[ ] done

User Story 3, Merchant Creation

As a visitor
When I visit the Merchant Index page
Then I see a link to create a new merchant
When I click this link
Then I am taken to '/merchants/new' where I  see a form for a new merchant
When I fill out the form with a new merchant's:
- name
- address
- city
- state
- zip
And I click the button to submit the form
Then a `POST` request is sent to '/merchants',
a new merchant is created,
and I am redirected to the Merchant Index page where I see the new Merchant listed.
```

```
[ ] done

User Story 4, Merchant Update

As a visitor
When I visit a merchant show page
Then I see a link to update the merchant
When I click the link
Then I am taken to '/merchants/:id/edit' where I  see a form to edit the merchant's data including:
- name
- address
- city
- state
- zip
The form fields are prepopulated with the merchant's current info
When I fill out the form with updated information
And I click the button to submit the form
Then a `PATCH` request is sent to '/merchants/:id',
the merchant's info is updated,
and I am redirected to the Merchant's Show page where I see the merchant's updated info
```

```
[ ] done

User Story 5, Merchant Delete

As a visitor
When I visit a merchant show page
Then I see a link to delete the merchant
When I click the link
Then a 'DELETE' request is sent to '/merchants/:id',
the merchant is deleted,
and I am redirected to the merchant index page where I no longer see this merchant
```

---

## Items
Items are sold on the site. They belong to a merchant.

```
[ ] done

User Story 6, Merchant Items Index

As a visitor
When I visit '/merchants/:merchant_id/items'
Then I see all the Items that belong to the Merchant with that merchant_id
```

```
[ ] done

User Story 7, Item Show

As a visitor
When I visit '/items/:id'
Then I see the item with that id including the item's:
- name
- active/inactive status
- price
- description
- image
- inventory
- the name of the merchant that sells the item
```

```
[ ] done

User Story 8, Merchant Item Creation

As a visitor
When I visit a Merchant Items Index page
Then I see a link to add a new item for that merchant
When I click the link
I am taken to '/merchants/:merchant_id/items/new' where I see a form to add a new item
When I fill in the form with the item's:
- name
- price
- description
- image
- inventory
Then a `POST` request is sent to '/merchants/:merchant_id/items',
a new item is created for that merchant,
that item has a status of 'active',
and I am redirected to the Merchant Items Index page where I see the new item
```

```
[ ] done

User Story 9, Item Update

As a visitor
When I visit an Item Show page
Then I see a link to update that Item
When I click the link
I am taken to '/items/:id/edit' where I see a form to edit the item's data including:
- name
- price
- description
- image
- inventory
When I click the button to submit the form
Then a `PATCH` request is sent to '/items/:id',
the item's data is updated,
and I am redirected to the Item Show page where I see the Item's updated information
```

---

## Extensions

```
[ ] done

User Story 10, Item Filter by Active Status

As a visitor
When I visit a Merchant Items Index page
Then I see a link to show only active items
And I also see a link to show only inactive items
When I click the link
Then my path is something like '/merchants/:merchant_id/items?active=true'
And I see only the Items sold by the merchant that are active/inactive.
```

```
[ ] done

User Story 11, Change Item's Active Status

As a visitor
When I visit an Item Show page
Then I see a link to change the Item's active status
Active items should have the link "deactivate"
Inactive items should have the link "activate"
When I click the link
Then a 'PATCH' request is sent to '/items/:id/activate' or 'items/:id/deactivate' (depending on the link)
and I am redirected to the Item Show page where I see the active status has been toggled
```

