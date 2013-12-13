## Cozy CLI

Collection of Command Line Interfaces to manage your Cozy applications
from the command line.

## Usage

    npm install cozy-cli -g

## Usage

    cozy-cli -h | --help | --version

## Home

Get list of installed applications:

    cozy-cli home applications list

## Bookmarks

Create a new bookmark in the Bookmark app

    cozy-cli bookmarks create <link> [--tags=<tags>]

## Todos

List task from a todo list:

    cozy-cli todos list <list_name>

Create and check tasks in a list:

    cozy-cli todos create <list_name> <task>
    cozy-cli todos check <list_name> <index>


