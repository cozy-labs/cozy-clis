request = require 'request-json'
path = require 'path'
fs = require 'fs'

{docopt} = require 'docopt'
log = require('printit')(date: false, prefix: null)

version = require('./package.json').version

# A cozy can handle a lot of applications. So, a CLI for Cozy means a lot of
# potential action. That's why this software is thinked in a modular way.
# In this file you will find the core CLI and the module (~ plugins) loader.
# Each module corresponds to a CLI of an application.

# Init doc
# It's base on docopt. Arguments management is described through a
# documentation string.
doc = """
Usage:
"""

# Path where modules are located.
modulesPath = path.join(path.dirname(fs.realpathSync(__filename)), 'clis')

# Get user Home directory depending of its system platform.
homeVar = if process.platform is 'win32' then 'USERPROFILE' else 'HOME'
userHome = process.env[homeVar]

# Helpers to know if a file is a JS file or not.
isJsFile = (fileName) ->
    extension = fileName.split('.')[1]
    firstChar = fileName[0]
    firstChar isnt '.' and extension is 'js'

# Load modules contained in the ./clis directory. Each of these module contains
# code to handle new sort of CLI.
loadModules = ->
    moduleFiles = fs.readdirSync modulesPath
    modules = {}
    for moduleFile in moduleFiles
        if isJsFile moduleFile
            name = moduleFile.split('.')[0]
            modulePath = path.join modulesPath, "#{name}"
            modules[name] = require modulePath
            doc += "\n" + modules[name].doc
    modules


# Get Cozy credentials from a config file located in the home folder of the
# user.
getCredentials = ->
    configFile = path.join userHome, '.cozy-config.json'
    try
        require configFile
    catch exception
        log.error """
No configuration file found. expected location : ~/.cozy-config.json
The file is maybe corrupted.
"""
        process.exit 1


# Load modules from clis directory
modules = loadModules doc

# Add docopt options
doc += "\n
cozy-cli -h | --help | --version
"

credentials = getCredentials()
url = credentials.url
password = credentials.password

# Run docopt on doc built from core one and module ones.
opts = docopt doc, version: version

# Check if action match a given module
# If yes, run this module with docopt args and an http client as argument. The
# client is already logged to the Cozy.
moduleName = process.argv[2]
if modules[moduleName]?
    client = request.newClient url
    client.post 'login', password: password, (err) ->
        if err
            log.error "Can't log to your Cozy"
            process.exit 1
        modules[moduleName].action opts, client
