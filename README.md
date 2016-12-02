[![Build Status](https://travis-ci.org/andela-bkanyolo/justdoit.svg?branch=develop)](https://travis-ci.org/andela-bkanyolo/justdoit)
[![Coverage Status](https://coveralls.io/repos/github/andela-bkanyolo/justdoit/badge.svg?branch=ch-refactor-135410513)](https://coveralls.io/github/andela-bkanyolo/justdoit?branch=ch-refactor-135410513)
[![Code Climate](https://codeclimate.com/github/andela-bkanyolo/justdoit/badges/gpa.svg)](https://codeclimate.com/github/andela-bkanyolo/justdoit)
[![Issue Count](https://codeclimate.com/github/andela-bkanyolo/justdoit/badges/issue_count.svg)](https://codeclimate.com/github/andela-bkanyolo/justdoit)

# JUSTDOIT


**Documentation** - [justdoit-api.herokuapp.com](http://justdoit-api.herokuapp.com).

**Source code** - [https://github.com/andela-bkanyolo/justdoit](https://github.com/andela-bkanyolo/justdoit).

# Running the application

### Install dependencies

You need to install the following:

1. [Ruby](https://github.com/rbenv/rbenv)
2. [PostgreSQL](http://www.postgresql.org/download/macosx/)
3. [Bundler](http://bundler.io/)
4. [Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
5. [RSpec](http://rspec.info/)

### Clone the repository

Clone the application to your local machine:

```
$ git clone https://github.com/andela-bkanyolo/justdoit.git
```

Install the dependencies

```
$ bundle install
```

Setup database and seed data

```
$ rake db:setup
```

To run the application;

```
$ rails s
```

To test the application;

```
$ rspec -fd
```

# Description

**Justdoit** is a restful and versioned API and all interactions will be defined using basic HTTP verbs.

### API limitations

It returns JSON only

## The API Endpoints

POST /bucketlists/ | Create a new bucket list
-----|-------
GET /bucketlists/ | List all the created bucket lists
GET /bucketlists/{id} | Get single bucket list
PUT /bucketlists/{id} | Update this bucket list
DELETE /bucketlists/{id} | Delete this single bucket list
POST /bucketlists/{bucket_id}/items/ | Create a new item in bucket list
GET /bucketlists/{bucket_id}/items | List all the created items in a bucket list
GET /bucketlists/{bucket_id}/items/{id} | Get a single item in a bucket list
PUT /bucketlists/{bucket_id}/items/{item_id} | Update a bucket list item
DELETE /bucketlists/{bucket_id}/items/{item_id} | Delete an item in a bucket list
