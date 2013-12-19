log = require('printit')(date: false, prefix: null)

module.exports =
    doc: "
cozy-clis bookmarks create <link> [--tags=<tags>]
"

    action: (opts, client) ->
        if opts.create
            link = opts["<link>"]
            data =
                url: link
                httpUrl: link
                title: link
                tags: [""]
                readableTags: ""
                description: ""
            client.post 'apps/bookmarks/bookmarks', data, (err, res, body) ->
                if err then log.error """
                    An error occurred, bookmark cannot be saved."""
                else
                    log.raw "Bookmark #{link} properly saved"
