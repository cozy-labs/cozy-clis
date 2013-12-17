## Cozy CLI

Collection of Command Line Interfaces to manage your Cozy applications
from the command line.

## Install

    npm install cozy-clis -g

## Usage

### Files

List all files stored in your Files app:

    cozy-clis files list

Download given file from your Files app:

    cozy-clis download <file_name>

Upload given file to the root of your Files app:

    cozy-clis upload <file_name>

### Contacts

List all your contact names

    cozy-clis contacts list

Display details for a contact

    cozy-clis contacts <contact_name>

### Todos

List task from a todo list:

    cozy-clis todos list <list_name>

Create and check tasks in a list:

    cozy-clis todos create <list_name> <task>
    cozy-clis todos check <list_name> <index>

### Bookmarks

Create a new bookmark in the Bookmark app

    cozy-clis bookmarks create <link> [--tags=<tags>]

### Home

Get list of installed applications:

    cozy-clis home applications list

### Basic options

    cozy-clis -h | --help | --version
