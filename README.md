# Jekyll Lab-Template with ORCID Integration

This repo provides a jekyll page template for lab teams. As a special feature it comes completely without JavaScript, Trackers, Cookies and is able to generate several pages automatically based on the commonly used ORCID. Instead of maintaining the team & publication pages manually you only need to specify the ORCID and start the jekyll server or build the page.

## Usage

### Projects

To add a new project you must create a new markdown file in the `_projects` folder. This file should contain the basic information about the project and may define some properties in the frontmatter like a project title, a description and an image.

```markdown
---
title: Another project
description: We are working on a a second project!
image: /assets/img/project.jpeg
---
```

### Team

To add a new team member simply create new markdown file in `_team` containing the orcid in the jekyll frontmatter. The further data will be fetched from orcid.

```markdown
---
orcid: 0000-0000-0000-0000
---
```

## Development

To simplify the development, especially when using Windows, a development environment using docker is provided. To start the dev server you only need to start the `docker-compose.dev.yml` using `docker-compose -f docker-compose.dev.yml up -d`. Afterwards the dev server is available on [port 4000](http://localhost:4000), so you can change your page and check the effect in the browser.

## License

The theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
