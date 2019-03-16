$(document).ready(
  function(){
    timer = $('span#test_timer')
    if ( timer.length )
      {
      var base_time = parseInt(timer.text())
      var testPassageId = timer.data('testPassageId')

      setInterval(function(){
        timer = $('span#test_timer')
        if (base_time <= 0) {
          window.location = "/test_passages/" + testPassageId + '/result';
        } else {
          base_time -= 1
          timer.text(base_time);
        }
      }, 1000);
    }
  });

