# Free Send Mails

![ruby](https://img.shields.io/badge/Ruby-2.4.2-green.svg)
![rails](https://img.shields.io/badge/Rails-5.0.1-green.svg)
[![Build Status](https://travis-ci.org/freesendmails/free-send-mails-api.svg?branch=master)](https://travis-ci.org/freesendmails/free-send-mails-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/dcb16cdaa411cc3d63ab/maintainability)](https://codeclimate.com/github/freesendmails/free-send-mails-api/maintainability)

`free send mails` This project is focused on making an email server available to static sites. In a simple and low code.

`Example:`

```html
<form action="http://www.api.freesendmails.com/v1/mails/youmail" method="POST">
  <div>
    <label>Name:</label>
    <input type="text" name="_name">
  </div>
  <div>
    <label>Email address:</label>
    <input type="email" name="_email">
  </div>
  <div>
    <label>Message:</label>
    <input type="text" name="_message">
  </div>
  <button type="submit">Submit</button>
</form>
```

## Demo app

Below you will be redirected to the direct demo of the site and you will also be able to see the two repositories of application codes.

-   [Live Demo](http://www.freesendmails.com/test-mail)
-   [Source code - Client](https://github.com/grassiricardo/free-send-mails-client)
-   [Source code - Api](https://github.com/grassiricardo/free-send-mails-api)

## Development

Familiarize yourself with the code and try to follow the same syntax conventions to make it easier for us to accept your pull requests.

### Getting the Code

1.  Clone the free-send-mails-api project:

    ```shell
    $ git clone https://github.com/grassiricardo/free-send-mails-api.git
    $ cd free-send-mails-api
    ```

### Run the application - (Without Docker)

1.  Install dependencies. We assume that you have already installed `Ruby on Rails` in your system.

    ```shell
    $ bundler
    ```

2.  Run the application.

    ```shell
    $ rails s
    ```

3.  Run the redis
    ```shell
    $ redis-server
    ```

4.  Run the sidekiq
    ```shell
    $ bundle exec sidekiq
    ```

### Run the application - (With Docker)

1.  Install dependencies and run application

    ```shell
    $ docker-compose up --build
    ```
