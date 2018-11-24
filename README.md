Requires Python 2

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

The `story-checlist.md` is appended to the end of every non-epic story.

## Rationale/Excuses:

- I use an equal (`=`) on the title line in case my titles need colons, like `Epic: Whatever`
- the INI section markers are slug names, these get turned into ID values later
- the script will process INI files in whatever natural order your OS reads them

## Run it

`python build-cannon.py`

All output will go into the `_output` folder as `cards.json` and `cards/(story_id).md`.
Simply copy those files into your cardcannon deploy and you're all set.

It also builds one big concatenated `stories.md` in the root of this project's folder
where each epic is printed as-is, includes a markdown line separator of `---`, and
numbers each story to look like this:

```
[ ] done

User Story 17
User Profile Show Page

As a registered user
When I visit my own profile page
Then I see all of my profile data on the page except my password
And I see a link to edit my profile data
```
