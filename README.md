# Team Sacramento Judo (teamsacramento.org)

A plain static HTML5 site - no framework, no build step, no backend. Open
`index.html` in a browser or upload the whole folder to any static host and
it works.

```
team-sacramento-judo-static/
├── index.html      Home
├── about.html       Home → About Us
├── history.html     Home → History
├── coaches.html      Home → Coaches
├── schedule.html
├── news.html
├── join.html         How do I join? (contact form)
├── css/style.css    All styles - design tokens + every page
├── js/main.js        Nav (hamburger/dropdown), footer year, contact form
└── images/           The 7 club photos
```

## Running it

There's nothing to install or build. Either:

- Double-click `index.html` to open it directly in a browser, or
- Serve the folder with any static file server, e.g. `python3 -m http.server`
  from inside this folder, then visit `http://localhost:8000`.

To deploy, upload this folder as-is to whatever's hosting
teamsacramento.org - GitHub Pages, Netlify, Cloudflare Pages, S3 + a CDN,
or a plain Apache/Nginx box all work the same way: just static files.

All internal links use root-relative paths (`/about.html`, `/css/style.css`,
etc.), which assumes the site is served from the domain root. If you ever
deploy it into a subfolder instead, those links would need to become
relative paths.

## How the "How do I join?" form works without a backend

There's no server here, so the contact form on `join.html` doesn't submit
anywhere - `js/main.js` builds a `mailto:` link from what's typed in and
opens the visitor's email app with the subject and body pre-filled. They
still have to hit send themselves. The form points at
`info@teamsacramento.org` - replace that with the club's real inbox in
`join.html` and `js/main.js` (search for `info@teamsacramento.org` in
both).

If you'd rather have messages land in an inbox without opening an email
app, swap the form for a static-form service instead (Formspree, Netlify
Forms, Getform, etc.) - drop their `action` URL into the `<form>` tag and
remove the `mailto:` logic in `initContactForm()`. That's the only place
in the whole site that would need outside help, since everything else is
plain content.

## Things to fill in before this goes live

A few sections have placeholder content (search for `NOTE for Tui` in the
HTML):

- **history.html** - the timeline years/copy are placeholders.
- **coaches.html** - bios and exact titles for each coach are placeholders.
- **schedule.html** - sample class times, not the real schedule.
- **news.html** - sample posts.
- **join.html** - the `info@teamsacramento.org` address is a placeholder.

## Editing nav or footer

There's no templating, so the nav and footer markup is duplicated at the
top/bottom of every page. If you add a page or change a link, update it in
all seven HTML files - search-and-replace across the folder is the
fastest way (e.g. `grep -rl "schedule.html" .` to find every file that
references a given link).

## Design notes

Palette and type are explained at the top of `css/style.css`: the
gold/blue come from a competition tatami, the red square is the club's own
stamp/seal mark, and the Home page hero recreates the look of a mat (gold
center, blue border) instead of a generic gradient.
