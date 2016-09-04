describe "BigSchedules", ->
  @timeout 15000

  before ->
    browser.get "/"
    .then ->
      browser.waitForAngular()

  after ->
    browser.manage().window().setPosition 0, 0
    browser.manage().window().maximize()

  describe "Get targetOriginal focus and get menu", ->

    popupCloseBtn = null
    targetOriginalInput = null
    targetDestinationInput = null
    originDropDown = null
    destDropDown = null
    searchBtn = null

    before ->
      popupCloseBtn = element By.id "main_feature_beta_span_close"
      targetOriginalInput = element By.id "targetOriginal"
      targetDestinationInput = element By.id "targetDestination"
      searchBtn = element By.id "main_a_search"

    it "Get targetOriginal focus", ->
      browser.sleep 1000
      
      popupCloseBtn.click().then ->
        
        targetOriginalInput.sendKeys "keel"
        .then ->
          originDropDownFirstChild = element By.css("#targetOriginal+.autocomplete>li>a:first-child")
          originDropDownFirstChild.click().then ->
            targetDestinationInput.sendKeys "hong"
            .then ->
              destDropDownFirstChild = element By.css("#targetDestination+.autocomplete>li>a:first-child")
              destDropDownFirstChild.click().then ->
                searchBtn.click().then ->
                  browser.sleep 10000

    it "Get data from search result", ->
      browser.sleep 10000

      carrierList = []
      # nextPage = null
      # state = "ok"

      # collectDataAndGoToNextPage = () ->
      # Q = require "q"
      # defer = Q.defer()

      carrierList.push element.all(By.css "[name=routes_a_carrier]").getText()
      console.log "!!! carrierList", carrierList
      # nextPage = element.all By.css ".pagination>.active+li:not(.disabled)"
      nextPage = element(By.css("[title='Next Page']:not(.disabled)"))
      console.log "!!! nextPage", nextPage

      # unless nextPage
      #   # TODO collect data
      #   defer.reject()
      #   return

      console.log "!!! nextPage.isPresent()", nextPage.isPresent()
      console.log "!!! nextPage.isDisplayed()", nextPage.isDisplayed()

      # Go to next page!
      nextPage.click().then ->
        carrierList.push element.all By.css "[name=routes_a_carrier]"
        console.log "!!! carrierList", carrierList
        # defer.resolve()
        return

      # return defer.promise

      # collectDataAndGoToNextPage()

      browser.sleep 5000

      # while state isnt "over"
      #   console.log "!!! state in loop", state
      #   continue if state is "waiting"
      #   state = "waiting"
      #   collectDataAndGoToNextPage().then ->
      #     state = "ok"
      #   .fail ->
      #     state = "over"

      # console.log "!!! state", state

      # functionResult = collectDataAndGoToNextPage()
      # console.log "!!! functionResult", functionResult
      # console.log "!!! functionResult.state", functionResult.state
      # browser.sleep 1000
      # status = functionResult.state
      # console.log "!!! status", status

      # status = null

      # collectDataAndGoToNextPage().then (result) ->
      #   status = result.state

      #   while status isnt "rejected"
      #     console.log "!!! status", status
      #     if status is "pending"
      #       continue
      #     functionResult = collectDataAndGoToNextPage()
      #     status = functionResult.state

      # Get unique carriers from data
      # console.log "!!! carrierList", carrierList











      
