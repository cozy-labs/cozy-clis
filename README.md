⚠️ This repository is deprecated. To import/export your data from your Cozy, you can use [ACH](https://github.com/cozy/ach).

---

## Cozy CLIs

At Cozy we spent most of our time in the command line. It's the most efficient
tool we use: it makes us more productive and it's super hackable. So, that
sounds logical to provide a Command Line Interface to Cozy.

Cozy-clis allows you to manage your Personal Cloud from the terminal.
Enjoy using it through your favorite alias. Perform automatic and batch
action on your data with bash scripts!

![screenshot](http://cozy.io/images-ext/cozyclis_screenshot.jpg)

## Install

    npm install cozy-clis -g

Add a configuration file located there `~/.cozy-config.json` and fill it like
this:

    { "url": "mycozyurl", "password": "mycozypassword"}

Do not put a trailing slash at the end of the url.

## Usage

### Calendar

List upcoming events

     cozy-clis calendar upcoming

Create new events

     cozy-clis calendar create 2013-12-25T14:00:00Z 2013-12-25T18:00:00Z xmas

### Contacts

List all your contact names

    cozy-clis contacts list

Display details for a contact

    cozy-clis contacts <contact_name>

### Files

List all files stored in your Files app:

    cozy-clis files list

Download given file from your Files app:

    cozy-clis download <file_name>

Upload given file to the root of your Files app:

    cozy-clis upload <file_name>

### Todos

List task from a todo list:

    cozy-clis todos list <list_name>

Create and check tasks in a list:

    cozy-clis todos create <list_name> <task>
    cozy-clis todos check <list_name> <index>

### Bookmarks

Create a new bookmark in the Bookmark app

    cozy-clis bookmarks create <link> [--tags=<tags>]

### PFM (banks)

Display your accounts: 

    cozy-cli pfm accounts

Display your bank operations for given account:

    cozy-cli pfm operations <account_number>

Display your expense to plot them:

    cozy-cli pfm expense <account_number>


### Home

Get list of installed applications:

    cozy-clis home applications list

### Basic options

    cozy-clis -h | --help | --version
