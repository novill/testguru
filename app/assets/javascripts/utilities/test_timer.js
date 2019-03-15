$(document).ready(
  function(){
    timer = $('span#test_timer')
    testPassageId = timer.data('testPassageId')
    timer.load('/test_passages/' + testPassageId + '/time_left');

    setInterval(function(){
      timer = $('span#test_timer')
      seconds_left = parseInt(timer.text())
      if (seconds_left <= 0) {
        window.location = "/test_passages/" + timer.data('testPassageId') + '/result';
      } else {
        timer.text(seconds_left - 1);
      }
    }, 1000);
  });

