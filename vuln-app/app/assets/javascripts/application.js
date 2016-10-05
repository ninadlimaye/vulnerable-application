//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

if($(".voting")) {
  $(window).on("popstate", function() {
      var action = location.hash.slice(1).split("-");
      if (action.length == 2) {
        $.get("/posts/" + action[1] + "/vote/" + action[0], function(data) {
          $(".voting").html(data["error"]);
          $(".vote-count").html(data["votes"]);
        });
      }
  });
}
