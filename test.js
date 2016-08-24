var page = require('webpage').create();
console.log("111");

page.onConsoleMessage = function(msg) {
  console.log(msg);
}

function waitFor(testFx, onReady, timeOutMillis) {
  var maxtimeOutMillis = timeOutMillis ? timeOutMillis : 3000, //< Default Max Timout is 3s
  start = new Date().getTime(),
  condition = false,
  interval = setInterval(function() {
    if ( (new Date().getTime() - start < maxtimeOutMillis) && !condition ) {
      // If not time-out yet and condition not yet fulfilled
      condition = (typeof(testFx) === "string" ? eval(testFx) : testFx()); //< defensive code
    } else {
      if(!condition) {
        // If condition still not fulfilled (timeout but condition is 'false')
        console.log("'waitFor()' timeout");
        phantom.exit(1);
      } else {
        // Condition fulfilled (timeout and/or condition is 'true')
        console.log("'waitFor()' finished in " + (new Date().getTime() - start) + "ms.");
        typeof(onReady) === "string" ? eval(onReady) : onReady(); //< Do what it's supposed to do once the condition is fulfilled
        clearInterval(interval); //< Stop this interval
      }
    }
  }, 250); //< repeat check every 250ms
};


page.open('http://www.bigschedules.com', function() {
  console.log("222");
  page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
    console.log("333");
    // page.render('bigschedules.png');
    waitFor(function() {
      // Check in the page if a specific element is now visible
      return page.evaluate(function() {
        return $("#targetOriginal").is(":visible");
      });
    }, function() {
      page.evaluate(function() {
        console.log('$("#targetOriginal").value', $("#targetOriginal").value);
        console.log('$("#targetDestination").value', $("#targetDestination").value);
        $("#targetOriginal").value = "Keelung, Taiwan (TWKEL)";
        $("#targetDestination").value = "Hong Kong, Hong Kong (HKHKG)";

        console.log('$("#targetOriginal").value', $("#targetOriginal").value);
        console.log('$("#targetDestination").value', $("#targetDestination").value);
        $("#main_a_search").click();
      });
      page.render('bigschedules2.png');
      console.log("The sign-in dialog should be visible now.");
      phantom.exit();
    });
  });
});
