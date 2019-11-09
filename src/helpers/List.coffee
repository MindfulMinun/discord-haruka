((name, root, factory) ->
    # UMD: https://git.io/fjxpW
    if define?.amd
        define([], factory)
    else if module?.exports
        module.exports = factory()
    else
        root[name] = factory()
)('List', self ? this, ->
    return class List
        constructor: (@arr) ->

        ###*
         * Performs a matrix transposition on a 2d matrix
         * @author MindfulMinun
         * @param {Array?} arr - The matrix to transpose or this if none
         * @returns {Array} The transposed matrix
         * @since Aug 30, 2019 - 3.1.0
         * @version 3.1.0
        ###
        transpose: (arr) ->
            arr ?= @arr
            Object.keys(arr[0]).map (e) ->
                arr.map (r) -> r[e]

        ###*
         * Selects a random element in the array
         * @author MindfulMinun
         * @param {Array?} arr - The array to choose from
         * @returns {Any} Return value description
         * @since Aug 30, 2019 - 3.1.0
         * @version 3.1.0
        ###
        choose: (arr) ->
            arr ?= @arr
            arr[Math.floor(Math.random() * arr.length)]

        ###*
         * Selects the last element of the array
         * @author MindfulMinun
         * @param {Array?} arr - The array to choose from
         * @returns {Any} The last element
         * @since Aug 30, 2019 - 3.1.0
         * @version 3.1.0
        ###
        last: (arr) ->
            arr ?= @arr
            arr[arr.length - 1]

        ###*
         * Selects the first element of the array
         * @author MindfulMinun
         * @param {Array?} arr - The array to choose from
         * @returns {Any} The first element
         * @since Aug 30, 2019 - 3.1.0
         * @version 3.1.0
        ###
        first: (arr) ->
            arr ?= @arr
            arr[0]

        ###*
         * Calculates the summation of all the elements
         * @author MindfulMinun
         * @param {Array?} arr - The array that's hopefully filled with numbers
         * @returns {Number} The sum of these
         * @since Aug 30, 2019 - 3.1.0
         * @version 3.1.0
        ###
        sum: (arr) ->
            arr ?= @arr
            arr.reduce((acc, val) -> acc + val)

        ###*
         * Calculates the product of all the elements
         * @author MindfulMinun
         * @param {Array?} arr - The array that's hopefully filled with numbers
         * @returns {Number} The product of these
         * @since Aug 30, 2019 - 3.1.0
         * @version 3.1.0
        ###
        product: (arr) ->
            arr ?= @arr
            arr.reduce((acc, val) -> acc * val)
)
