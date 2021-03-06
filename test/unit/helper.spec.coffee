#==============================================================================
# lib/helper.js module
#==============================================================================
describe 'helper', ->
  helper = require '../../lib/helper'

  #==============================================================================
  # helper.browserFullNameToShort()
  #==============================================================================
  describe 'browserFullNameToShort', ->

    # helper function
    expecting = (name) ->
      expect helper.browserFullNameToShort name

    it 'should parse iOS', ->
      expecting('Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 ' +
                '(KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25').
           toBe 'Safari 6.0 (iOS)'


    it 'should parse Linux', ->
      expecting('Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081216 ' +
                'Ubuntu/8.04 (hardy) Firefox/2.0.0.19').
           toBe 'Firefox 2.0 (Linux)'


    it 'should degrade gracefully when OS not recognized', ->
      expecting('Mozilla/5.0 (X11; U; FreeBSD; i386; en-US; rv:1.7) Gecko/20081216 Firefox/2.0.0.19').
           toBe 'Firefox 2.0'


    it 'should parse Chrome', ->
      expecting('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.7 ' +
                '(KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.7').
           toBe 'Chrome 16.0 (Mac)'

      expecting('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.15 ' +
                '(KHTML, like Gecko) Chrome/18.0.985.0 Safari/535.15').
           toBe 'Chrome 18.0 (Mac)'


    it 'should parse Firefox', ->
      expecting('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0.1) Gecko/20100101 ' +
                'Firefox/7.0.1').
           toBe 'Firefox 7.0 (Mac)'


    it 'should parse Opera', ->
      expecting('Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; en) Presto/2.9.168 ' +
                'Version/11.52').
           toBe 'Opera 11.52 (Mac)'


    it 'should parse Safari', ->
      expecting('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.52.7 ' +
                '(KHTML, like Gecko) Version/5.1.2 Safari/534.52.7').
           toBe 'Safari 5.1 (Mac)'


    it 'should parse IE7', ->
      expecting('Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; SLCC1; ' +
                '.NET CLR 2.0.50727; .NET4.0C; .NET4.0E)').
           toBe 'IE 7.0 (Windows)'


    it 'should parse IE8', ->
      expecting('Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; ' +
                'SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; ' +
                '.NET4.0E; InfoPath.3)"').
           toBe 'IE 8.0 (Windows)'


    it 'should parse IE9', ->
      expecting('Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0; ' +
                '.NET CLR 2.0.50727; SLCC2; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center ' +
                'PC 6.0)').
           toBe 'IE 9.0 (Windows)'


    it 'should parse IE10', ->
      expecting('Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0; ' +
                '.NET4.0E; .NET4.0C)').
           toBe 'IE 10.0 (Windows)'


    it 'should parse PhantomJS', ->
      expecting('Mozilla/5.0 (Macintosh; Intel Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) ' +
                'PhantomJS/1.6.0 Safari/534.34').
           toBe 'PhantomJS 1.6 (Mac)'


  #==============================================================================
  # helper.isDefined()
  #==============================================================================
  describe 'isDefined', ->
    isDefined = helper.isDefined

    it 'should return true if defined', ->
      expect(isDefined()).toBe false
      expect(isDefined undefined).toBe false

      expect(isDefined false).toBe true
      expect(isDefined 0).toBe true
      expect(isDefined null).toBe true
      expect(isDefined '').toBe true


  #==============================================================================
  # helper.camelToSnake()
  #==============================================================================
  describe 'camelToSnake', ->
    camelToSnake = helper.camelToSnake

    it 'should convert camelCase string to snake_case', ->
      expect(camelToSnake 'OneMoreThing' ).toBe 'one_more_thing'


  #==============================================================================
  # helper.dashToCamel()
  #==============================================================================
  describe 'dashToCamel', ->
    dashToCamel = helper.dashToCamel

    it 'should convert dash-case to camelCase', ->
      expect(dashToCamel 'one-more-thing' ).toBe 'oneMoreThing'
      expect(dashToCamel 'one' ).toBe 'one'


  #==============================================================================
  # helper.arrayRemove()
  #==============================================================================
  describe 'arrayRemove', ->
    arrayRemove = helper.arrayRemove

    it 'should remove object from array', ->
      a = 'one'; b = []; c = {}; d = -> null
      collection = [a, b, c, d]

      expect(arrayRemove collection, b).toBe true
      expect(collection).toEqual [a, c, d]

      expect(arrayRemove collection, {}).toBe false
      expect(collection).toEqual [a, c, d]

      expect(arrayRemove collection, d).toBe true
      expect(collection).toEqual [a, c]

      expect(arrayRemove collection, a).toBe true
      expect(collection).toEqual [c]


  #==============================================================================
  # helper.merge()
  #==============================================================================
  describe 'merge', ->

    it 'should copy properties to first argument', ->
      destination = {a: 1, b: 2}
      result = helper.merge destination, {a: 4, c: 5}

      expect(destination.a).toBe 1
      expect(result).toEqual {a: 4, b: 2, c: 5}


  #==============================================================================
  # helper.isUrlAbsolute()
  #==============================================================================
  describe 'isUrlAbsolute', ->

    it 'should check http/https protocol', ->
      expect(helper.isUrlAbsolute 'some/path/http.html').toBe false
      expect(helper.isUrlAbsolute '/some/more.py').toBe false
      expect(helper.isUrlAbsolute 'http://some.com/path').toBe true
      expect(helper.isUrlAbsolute 'https://more.org/some.js').toBe true


  #==============================================================================
  # helper.formatTimeInterval()
  #==============================================================================
  describe 'formatTimeInterval', ->

    it 'should format into seconds', ->
      expect(helper.formatTimeInterval 23000).toBe '23 secs'


    it 'should format into minutes', ->
      expect(helper.formatTimeInterval 142000).toBe '2 mins 22 secs'


    it 'should handle singular minute or second', ->
      expect(helper.formatTimeInterval 61000).toBe '1 min 1 sec'


    it 'should round to miliseconds', ->
      expect(helper.formatTimeInterval 163017).toBe '2 mins 43.017 secs'


  #==============================================================================
  # helper.mkdirIfNotExists()
  #==============================================================================
  describe 'mkdirIfNotExists', ->

    fsMock = require('mocks').fs
    loadFile = require('mocks').loadFile

    done = null

    # async helper
    waitForDoneAnd = (resume) ->
      waitsFor (-> done.callCount), 'done callback', 50
      runs resume if resume

    fs = fsMock.create
      home:
        'some.js': fsMock.file()

    # load file under test
    m = loadFile __dirname + '/../../lib/helper.js', {fs: fs, lodash: require 'lodash'}
    mkdirIfNotExists = m.exports.mkdirIfNotExists


    beforeEach ->
      done = jasmine.createSpy 'done'

    it 'should not do anything, if dir already exists', ->
      mkdirIfNotExists '/home', done
      waitForDoneAnd()


    it 'should create directory if it does not exist', ->
      mkdirIfNotExists '/home/new', done
      waitForDoneAnd ->
        stat = fs.statSync '/home/new'
        expect(stat).toBeDefined()
        expect(stat.isDirectory()).toBe true


    it 'should create even parent directories if it does not exist', ->
      mkdirIfNotExists '/home/new/parent/child', done
      waitForDoneAnd ->
        stat = fs.statSync '/home/new/parent/child'
        expect(stat).toBeDefined()
        expect(stat.isDirectory()).toBe true

