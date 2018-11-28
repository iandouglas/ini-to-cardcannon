# CardCannon

Adapated from Waffle.io's CardCannon project (github.com/waffleio/cardcannon)


## app.js

Main application that runs on Glitch. Will listen for a GitHub issue for a supported repo where the title of the GitHub issue is `bootstrap <project-name>` where `project_name` is defined previously in the folder structure of this repo to have pre-built User Story cards written and ready to inject into that GitHub repo's issues stream.

When used in conjunction with Waffle.io, the repo's waffle board will show all user story cards with dependencies and requirements for implementation.

## build-cannon.py

Requires Python 2, and builds a set of CardCannon-compatible files for `app.js` to inject as GitHub issues. Also builds a main "stories.md" document for your project.

### Setup

Make a folder for your project name, like "little_shop"

Within that folder, create one or more files ending in .ini that will process as user stories and epics for the project. Also include a `story-checklist.md` file; this markdown will be appended to every user story (but not epics) so GitHub and Waffle can utilize markdown checkboxes for progress. You can leave this file blank if you want but it must exist.

### INI file structure

Structure your INI files in this format:

```
[story-slug]
title = Epic: Whatever
labels: to-do, whatever
child_of: story-slug-of-parent
story_text: line 1 of story
    line 2 of story
    line 3 of story
    etc

[story-slug-2]
title = A Very Whatever Story
labels: to-do, whatever
child_of: story-slug
story_text: line 1 of story
    line 2 of story
    line 3 of story
    etc

[story-slug-3]
title = A Very Whatever Story
labels: to-do, whatever
child_of: story-slug
depends_on: story-slug-2
story_text: line 1 of story
    line 2 of story
    line 3 of story
    etc

```

#### Rationale/Excuses:

- I use an equal (`=`) on the title line in case my titles need colons, like `Epic: Whatever`
- the INI section markers are slug names, these get turned into ID values later
- the script will process INI files in whatever natural order your OS reads them

### Run it

`python build-cannon.py project_name`

All output will go into the `_output/project_name` folder as `cards.json` and `cards/(story_id).md`. Deploy this whole repo to Glitch and you're all set.

### More about stories.md
This Python script also builds one big concatenated `stories.md` in the root of this project's folder where each epic is printed as-is, includes a markdown line separator of `---`, and numbers each story to look like this:

```
[ ] done

User Story 17
User Profile Show Page

As a registered user
When I visit my own profile page
Then I see all of my profile data on the page except my password
And I see a link to edit my profile data
```
