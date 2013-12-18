log = require('printit')(date: false, prefix: null)

module.exports =
    doc: """
cozy-cli calendar upcoming
cozy-cli calendar create <start> <end> <summary>
"""
    action: (opts, client) ->
        client.host += 'apps/calendar/'

        if opts.upcoming
            client.get 'events', (err, res, events) ->
                if err
                    log.error "Can't retrieve events."
                else
                    events.sort (event1, event2) ->
                        date1 = event1.start
                        date2 = event2.start
                        date1 = getDateFormat new Date date1
                        date2 = getDateFormat new Date date2

                        date2.localeCompare date1

                    log.lineBreak()
                    for event in events
                        date = new Date event.start
                        now = new Date()

                        if date > now
                            log.raw event.description
                            log.raw "@ #{event.place}"
                            log.raw event.start
                            log.raw event.end
                            log.lineBreak()

        else if opts.create

            process.env.TZ = 'UTC'
            data =
                description: opts["<summary>"]
                start: new Date opts["<start>"]
                end: new Date opts["<end>"]
                place: ""

            client.post 'events', data, (err, res, body) ->
                if err
                    log.raw err
                    log.error "cannot create event"
                else
                    log.info "Event successfully created."


pad = (number) ->
    number = new String number
    if number.length is 1
        "0#{number}"
    else
        number

getDateFormat = (date) ->
    day = pad date.getDate()
    month = pad(date.getMonth() + 1)
    year = date.getFullYear()
    hours = pad date.getHours()
    minutes = pad date.getMinutes()
    "#{year}-#{month}-#{day}-#{hours}-#{minutes}"
