log = require('printit')(date: false, prefix: null)

module.exports =
    doc: """
cozy-clis pfm accounts
cozy-clis pfm operations <account_number>
cozy-clis pfm expense <account_number>
"""
    action: (opts, client) ->
        client.host += 'apps/pfm/'

        if opts.accounts
            client.get 'bankaccounts', (err, res, accounts) ->
                log.lineBreak()
                for account in accounts
                    log.raw account.title
                    log.raw account.bank
                    log.raw account.accountNumber
                    log.lineBreak()

        if opts.operations

            accountNumber = opts["<account_number>"]
            log.lineBreak()
            client.get 'bankoperations', (err, res, operations) ->
                operations.sort (operation1, operation2) ->
                    date1 = operation1.date.substring 0, 10
                    date2 = operation2.date.substring 0, 10
                    date1.localeCompare date2

                for operation in operations
                    if operation.bankAccount is accountNumber
                        log.raw operation.date.substring 0, 10
                        log.raw operation.raw
                        log.raw operation.amount
                        log.lineBreak()

        else if opts.expense
            # TODO: manage days where there is no expense.
            accountNumber = opts["<account_number>"]
            client.get 'bankoperations', (err, res, operations) ->
                operations.sort (operation1, operation2) ->
                    date1 = operation1.date.substring 0, 10
                    date2 = operation2.date.substring 0, 10
                    date1.localeCompare date2

                i = 0
                currentAmount = 0
                currentDate = null
                for operation in operations

                    if operation.bankAccount is accountNumber \
                    and operation.amount < 0

                        date = operation.date.substring 0, 10

                        currentDate = date unless currentDate?
                        if date is currentDate
                            currentAmount -= operation.amount
                        else
                            log.raw "#{i++} #{currentAmount}"
                            currentAmount = -1 * operation.amount
                            currentDate = date


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
