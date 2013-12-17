## Cozy CLI

Collection of Command Line Interfaces to manage your Cozy applications
from the command line.

## Install

    npm install cozy-cli -g

## Usage

### Files

List all files stored in your Files app:

    cozy-cli files list

Download given file from your Files app:

    cozy-cli download <file_name>

Upload given file to the root of your Files app:

    cozy-cli upload <file_name>

### Contacts

List all your contact names

    cozy-cli contacts list

Display details for a contact

    cozy-cli contacts <contact_name>

### Todos

List task from a todo list:

    cozy-cli todos list <list_name>

Create and check tasks in a list:

    cozy-cli todos create <list_name> <task>
    cozy-cli todos check <list_name> <index>

### Bookmarks

Create a new bookmark in the Bookmark app

    cozy-cli bookmarks create <link> [--tags=<tags>]

### Home

Get list of installed applications:

    cozy-cli home applications list

### Basic options

    cozy-cli -h | --help | --version
