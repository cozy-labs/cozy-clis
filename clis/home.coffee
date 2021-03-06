log = require('printit')(date: false, prefix: null)

module.exports =
    doc: "
cozy-clis home applications list
"
    action: (opts, client) ->
        if opts.list
            client.get 'api/applications', (err, res, applications) ->
                log.raw "Installed Applications"
                log.lineBreak()
                log.raw app.name for app in applications.rows
                log.lineBreak()
