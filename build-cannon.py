import json
import os
import re
from shutil import copy2
import ConfigParser
from collections import OrderedDict

def ConfigSectionMap(section):
    dict1 = {}
    options = Config.options(section)
    for option in options:
        try:
            dict1[option] = Config.get(section, option).replace('\\n', '')
            if dict1[option] == -1:
                DebugPrint("skip: %s" % option)
        except:
            print("exception on %s!" % option)
            dict1[option] = None
    return dict1

stories = OrderedDict()
story_titles = {}
# list of folders to ignore
EXCLUDED = [
  '.git',
  '_output',
  '_output/cards',
]

with open('story-checklist.md') as x: CHECKLIST = x.read()

story_output = []

def get_id_by_slug(slug):
    global stories
    deps = []
    dep_slugs = []
    if isinstance(slug, list):
        dep_slugs = slug
    else:
        if ',' in slug:
            dep_slugs = [x.strip() for x in slug.split(',')]
        else:
            dep_slugs = [slug]
    for story_slug in dep_slugs:
        deps.append(stories[story_slug]['id'])
    return deps

path = "./"
for filename in os.listdir(path):
    if filename not in EXCLUDED and re.match(".+.ini", filename):
        config = ConfigParser.RawConfigParser()
        config.read(filename)
        for section_name in config.sections():
            print(section_name)
            bits = config.items(section_name)
            story = {
                'title': config.get(section_name, 'title'),
                'labels': [x.strip() for x in config.get(section_name, 'labels').split(',')],
                'id': len(stories) + 1
            }
            if config.get(section_name, 'title') in story_titles:
                print("*** Story title '{}' is not unique within {}, it has been seen before and must be unique ***".format(story['title'], filename))
            else:
                story_titles[config.get(section_name, 'title')] = True
                options = config.options(section_name)
                # print(options)
                if 'child_of' in config.options(section_name):
                    story['child_of'] = config.get(section_name, 'child_of')
                if 'depends_on' in config.options(section_name):
                    story['depends_on'] = config.get(section_name, 'depends_on')
                # print(story)
                story['story_text'] = config.get(section_name, 'story_text')
                stories[section_name] = story

                story_output.append({
                    'title': story['title'],
                    'text': story['story_text'],
                })

markdown_output = open('stories.md', 'w')
id = 1
for story in story_output:
    if 'Epic:' in story['title']:
        markdown_output.write("---\n\n{}\n\n".format(story['text']))
    else:
        markdown_output.write("```\n[ ] done\n\nUser Story {}\n{}\n\n{}\n```\n\n".format(id, story['title'], story['text']))
        id += 1
markdown_output.close()

print('outputing all stories per Waffle Cannon')
with open("_output/cards.json", 'w') as f:
    waffle_stories = []
    for story in stories:
        story = stories[story]
        # print(story['title'])
        if 'child_of' in story:
            story['childOf'] = get_id_by_slug(story['child_of'])[0]
            del story['child_of']
        if 'depends_on' in story:
            story['dependsOn'] = get_id_by_slug(story['depends_on'])
            del story['depends_on']
        if 'slug' in story:
            del story['slug']
        with open('_output/cards/{}.md'.format(story['id']), 'w') as f2:
            if 'Epic:' in story['title']:
                f2.write("{}".format(story['story_text']))
            else:
                f2.write("```\n{}\n```\n\n{}".format(story['story_text'], CHECKLIST))
        if 'story_text' in story:
            del story['story_text']
        waffle_stories.append(story)
    f.write(json.dumps(waffle_stories, sort_keys=True, indent=2, separators=(',', ': ')))
