# Qanda - Q&A with Markdown

A Rails app that implements:

* Google OAuth
* asking and answering questions (with Markdown support)
* full-text search in titles and bodies of the questions

[![Build Status](https://travis-ci.com/mediafinger/qanda.svg?branch=master)](https://travis-ci.com/mediafinger/qanda)

## Installation

On your command line run:

`git clone git@github.com:mediafinger/qanda.git`

Change to the newly created directory and run:

`bundle install`

Which needs **Ruby** `2.7` or `3.0` (the app was originally developed under Ruby `2.5` and later updated to `2.6`) and the **gem bundler**. The CI is testing against all supported Ruby versions.
When all gems have been installed, execute:

`bin/rails db:setup`

This will create the _development_ and _test_ database. **You need to have _Postgres_ installed**.

## How to run the tests

`bin/rails ci` will execute:

* `rubocop` - to ensure a consistent style
* `rspec` - to run all existing specs
* `bundle_audit` - to check for vulnerabilities in the gems

You can also just run rspec alone: `bundle exec rspec spec`

### What is tested

The `models` are well covered in the tests. And one feature test ensures that the whole `workflow` does work in the browser:

* login
* asking a question
* answering a question
* searching a question
* logout

Writing _'unit'_ and _'integration'_ tests are both important to me. At the same time I am willing to skip most of the other kinds of tests Rails does offer, as they usually do not add enough value for the time invested (e.g. controller tests).

## How to start the application

Before starting the server, you will have to add your **Google Developer credentials** to a new file which you have to name: `.env.development.local`

This file is listed in _.gitignore_ so you won't accidentally publish your secrets. As the name suggests, it will only be loaded in development mode.

Please add this code together with your `client_id` and your `secret` to the new file:

```shell
export GOOGLE_OAUTH2_CLIENT_ID=
export GOOGLE_OAUTH2_CLIENT_SECRET=
```

> If you don't have a client_id and secret yet and don't know how to obtain it, please follow this instructions:  
 https://www.themarketingtechnologist.co/google-oauth-2-enable-your-application-to-access-data-from-a-google-user/

Once this is done, you can start the server:

`bin/rails server` will make the app available at http://localhost:3000/

You will be redirected to **Google** to authenticate yourself. On success the list of existing questions will be displayed.

## How to use the app

Actually I hope it is self-explanatory. You can:

* ask a question (using markdown in the body)
* list questions
* open a question
* answer the opened question (using markdown in the body)
* search in questions
* logout

### How to use the search

* search in titles (on / off)
* search in bodies (on / off)
* allow any word to match, or expect the result to contain all words
* it is case-insensitive
* special characters like `* _ - / ...` are ignored
* only full words match: `bristo` or `Bristols` would not match `Bristol`

---

## Development notes

Some notes that didn't fit into the preceding sections.

I've built this app the Rails (5) way. And to my own surprise I don't had to add an `app/services` folder (but it is still a small app). Apart from that I followed what I think are best practices and idiomatic Ruby (enforced by `rubocop`). In total I spent around three working days on it (I forgot to use my time-tracking app).

### Dependencies

* This app was developed and tested under `Ruby 2.5.0` and later updated to `2.6.1`. Since the update to Rails 7.x Ruby `2.7.x` or `3.x` are required.
* It used `Rails 5.2`, was then updated to `Rails 6.1` and to `Rails 7.0.0.alpha` and needs a `Postgres database`, as the fulltext search relies on Postgres features.
* Google authentication is done with `omniauth-google-oauth2` which depends on `omniauth`.
* The configuration relies on the `dotenv-rails` gem. It was not tested in a Docker environment (but PRs are always welcome).
* Markdown rendering is done with the `redcarpet` gem and the `rouge` plugin is used for code syntax highlighting.
* Tests are written with `rspec` and the feature tests use `capybara`. `factory_bot` builds and creates instances.

### What the app does not

As this app was created with limited time, it does not include some things a production app should include.

* OAuth tokens do not expire
* The OAuth image URL is fetched and stored, but never used
* The design is functional at best
* There are no tests to ensure that the markdown is rendered

### Missing Search features

The **Search** get's it's own section, as it feels like the most incomplete part. Some search features had been added, but excluded again, as they seemed to be incompatible with the other desired features (and I didn't invest the time to find a solution).

* Search terms can not be excluded, a pending test is left, as the feature was working already.
* Stemming is unfortunately not included in this version. The feature was working already, but I didn't like the side effects. Some commented out code and pending tests are left. This does mean, that the search terms must match exactly. There is no support for synonyms.
* While non-words are removed from the query, stop-words are not.
* Accents should be ignored in searches, in this version they are significant.
* And lastly - and for a production app most importantly - there is no search index being created. I wanted to save `GIN` based `tsvector` indexes to the database, but didn't find the time to do so.

For an application that does not come with very high load or special demands to the search, I would always feel comfortable to implement it with Postgres (and indexes). It definitely comes with a much lower overhead than a specialized search system like ElasticSearch / Solr / Sphinx.

A drawback of the Postgres fulltext-search is that it works best with English. Very international apps would have to measure if this solution would be good enough for their audience and use cases.

### Time sinks

I wasted a lot of time trying to get the workflow tested in a `system test`. For reasons that are still unknown to me the combination of `rspec` and `omniauth` led always to a `CSRF` issue. Only when I refactored the spec to the `feature/workflow_spec` it was successfully executing.

I also spent a lot of time reading documentation about `Postgres' GIN tsvector indexes for fulltext-search` and how to set them up in a Rails app - only to then not finding the time to actually implement them.
