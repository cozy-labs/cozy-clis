log = require('logit')(date: false, prefix: null)

module.exports =
    doc: "
    cozy-cli home applications list
"

    action: (opts, client) ->
        if opts.list
            client.get 'api/applications', (err, res, applications) ->
                log.raw "Installed Applications"
                log.break()
                log.raw app.name for app in applications.rows
                log.break()
