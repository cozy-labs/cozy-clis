log = require('logit')(date: false, prefix: null)

module.exports =
    doc: """
cozy-cli files list
cozy-cli files download <file_name>
cozy-cli files upload <file_name>
"""
    action: (opts, client) ->
        client.host += 'apps/files/'

        if opts.list

            getFiles client, (files) ->
                log.raw "Files stored in your Cozy Files"
                log.lineBreak()

                files = files.sort (file1, file2) ->
                    path1 = "#{file1.path}/#{file1.name}"
                    path2 = "#{file2.path}/#{file2.name}"
                    path1.localeCompare(path2)

                for file in files
                    log.raw "#{file.path}/#{file.name}"

                log.lineBreak()

        if opts.download

            getFiles client, (files) ->
                fileName = opts["<file_name>"]
                fileFound = false

                for file in files

                    if "/#{fileName}" is "#{file.path}/#{file.name}"
                        fileFound = true
                        path = "files/#{file.id}/attach/#{fileName}"
                        client.saveFile path, fileName, (err) ->

                            if err
                                log.error err
                                process.exit 1

                            else
                                log.info "File #{fileName} saved"
                                process.exit 0

                log.error "No file found with this name." unless fileFound

        if opts.upload
            # Dirty implementation, need to handle directories properly.
            fileName = opts["<file_name>"]
            data =
                path: ""
                name: fileName
                filename: fileName

            client.sendFile "files", fileName, data, (err, res, body) ->

                if err
                    log.error err
                    process.exit 1
                else if JSON.parse(body).error
                    log.error JSON.parse(body).msg
                    process.exit 1
                else
                    log.info "File uploaded succcessfully"



getFiles = (client, callback) ->
    client.get 'files', (err, res, files) ->

        if err
            log.raw err
            log.error 'Cannot retrieve files'
            process.exit 1

        else
            callback files
