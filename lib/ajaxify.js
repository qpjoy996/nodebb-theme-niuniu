$(document).ready(() => {
  let countDoms = $('[component="post/reply-count"]')
  countDoms.each(function() {
    var btn = $(this);
    require(['forum/topic/replies'], function (replies) {
      replies.init(btn);
    });
  })

  $(window).on('action:ajaxify.end', function(event, data) {
    let countDoms = $('[component="post/reply-count"]')
    countDoms.each(function() {
      var btn = $(this);
      require(['forum/topic/replies'], function (replies) {
        replies.init(btn);
      });
    })
  });

})
