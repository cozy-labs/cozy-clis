log = require('printit')(date: false, prefix: null)

module.exports =
    doc:"
cozy-cli todos list <list_name>\n
cozy-cli todos create <list_name> <task>\n
cozy-cli todos check <list_name> <index>
"

    action: (opts, client) ->

        listName = opts["<list_name>"]
        if opts.create
            getList client, listName, (list) ->
                createTask client, list, opts["<task>"]

        else if opts.check
            getList client, listName, (list) ->
                checkTask client, list, opts["<index>"]

        else if opts.list
            getList client, listName, (list) ->
                displayTasks client, list


createTask = (client, list, task) ->
    data = description: task
    client.post "apps/todos/todolists/#{list.id}/tasks", data, (err, res, tasks) ->
        if err
            console.log body

        log.raw "task successfully created"


checkTask = (client, list, index) ->
    client.get "apps/todos/todolists/#{list.id}/tasks", (err, res, tasks) ->
        index = index - 1
        if index < 0 or index >= tasks.length
            log.error 'There is no task with that index in given list.'
        else
            task = tasks.rows[index]
            task.done = true
            path = "apps/todos/todolists/#{list.id}/tasks/#{task.id}/"
            client.put path, task, \
                       (err, res, body) ->
                if err
                    log.error "Error occured, can't change task state"
                    console.log body
                else
                    log.info "Task successfully checked."


displayTasks = (client, list) ->
    client.get "apps/todos/todolists/#{list.id}/tasks", (err, res, tasks) ->
        i = 0
        reverseList = tasks.rows.reverse()
        nbTasks = tasks.rows.length
        for task in reverseList
            reverseIndex = nbTasks - (i++)
            log.raw "#{reverseIndex}. #{task.description}"


getList = (client, listName, callback) ->
    console.log listName

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

        if listNotFound
            log.error 'List not found'
            process.exit 1
