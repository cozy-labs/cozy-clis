log = require('printit')(date: false, prefix: null)

module.exports =
    doc: """
cozy-cli contacts list
cozy-cli contacts details <contact_name>
"""
    action: (opts, client) ->
        client.host += 'apps/contacts/'

        if opts.list

            getContacts client, (contacts) ->
                log.lineBreak()
                contacts.sort (contact1, contact2) ->
                    contact1.fn.localeCompare(contact2.fn)

                for contact in contacts
                    log.raw contact.fn
                log.lineBreak()

        else if opts.details

            getContacts client, (contacts) ->
                found = false
                contactName = opts["<contact_name>"]

                for contact in contacts
                    if contact.fn.indexOf(contactName) isnt -1
                        printContact contact
                        found = true

                log.error "Contact not found" unless found


printContact = (contact) ->
    log.raw contact.fn
    log.lineBreak()
    for point in contact.datapoints
        log.raw "#{point.name} - #{point.type}: #{point.value}"


getContacts = (client, callback) ->
    client.get 'contacts', (err, res, files) ->

        if err
            log.raw err
            log.error 'Cannot retrieve files'
            process.exit 1

        else
            callback files
