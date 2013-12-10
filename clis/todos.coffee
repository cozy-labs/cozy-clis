log = require('logit')(date: false, prefix: null)

module.exports =
    doc: "
    cozy-cli todos list <list_name>\n
    cozy-cli todos list <list_name> create <task>
"

    action: (opts, client) ->
        console.log "tofod"

        if opts.create
            getList client, listName, (list) ->
                createTask client, list, opts["<task>"]
        else if opts.list
            listName = opts["<list_name>"]
            getList client, listName, (list) ->
                displayTasks client, list


createTasks = (client, list, task) ->
    data = description: task
    client.post "apps/todos/todolists/#{list.id}/tasks", data, (err, res, tasks) ->
        if err
            console.log body

        log.raw "task successfully created"



displayTasks = (client, list) ->
    client.get "apps/todos/todolists/#{list.id}/tasks", (err, res, tasks) ->
        for task in tasks.rows
            log.raw task.description


getList = (client, listName, callback) ->
    client.get 'apps/todos/todolists', (err, res, lists) ->
        if err
            log.error 'Cannot retrieve todo-lists informations'
            process.exit 1
        listNotFound = true
        for list in lists.rows
            if list.title is listName
                callback list
                listNotFound = false
                break
        log.error 'List not found'
        process.exit 1
