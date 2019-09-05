List = require './List'
module.exports = tableToAscii = (tbl) ->
    tbl = tbl.map((row) -> row.map((el) ->
        el.slice(0, 30)
    ))
    if tbl.length is 1
        out = tbl[0].join ' | '
    else
        wmatrix = tbl.map((row) -> row.map((s) -> s.length + 1))
        widths = List::transpose(wmatrix).map((col) -> Math.max col...)
        sum = List::sum widths
        line = '+' + widths.map((l) -> '-'.repeat(l + 1)).join('+') + '+'
        out = ''
        out += line
        out += '\n'
        for row in tbl
            for el, i in row
                el = el.replace('⋮', '…')
                break if out.length > 1024 - (2 * line.length)
                out += "| " + el.padEnd(widths[i])
            out += '|\n'
            # out += "#{line}\n"
        out += "#{line}\n"
        return out
