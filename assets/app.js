(function() {

  /**
   * Obtains parameters from the hash of the URL
   * @return Object
   */
  function getHashParams() {
    var params = new URLSearchParams(window.location.search);

    return params;
  }
  Handlebars.registerHelper('json', function(context) {
    return JSON.stringify(context, null, 2)
  });

  var userProfileSource = document.getElementById('user-profile-template').innerHTML,
      userProfileTemplate = Handlebars.compile(userProfileSource),
      userProfilePlaceholder = document.getElementById('user-profile');

  var oauthSource = document.getElementById('oauth-template').innerHTML,
      oauthTemplate = Handlebars.compile(oauthSource),
      oauthPlaceholder = document.getElementById('oauth');

  var jsonResponseSource = document.getElementById('json-response-template').innerHTML,
      jsonResponseTemplate = Handlebars.compile(jsonResponseSource),
      jsonResponsePlaceholder = document.getElementById('response');

  var params = getHashParams();

  var access_token = params.get('access_token'),
      refresh_token = params.get('refresh_token'),
      error = params.get('error');

  if (error) {
    alert('There was an error during the authentication');
  } else {
    if (access_token) {
      // render oauth info
      oauthPlaceholder.innerHTML = oauthTemplate({
        access_token: access_token,
        refresh_token: refresh_token
      });

      $.ajax({
          url: 'https://api.bitbucket.org/2.0/user',
          headers: {
            'Authorization': 'Bearer ' + access_token
          },
          success: function(response) {
            userProfilePlaceholder.innerHTML = userProfileTemplate(response);
            jsonResponsePlaceholder.innerHTML = jsonResponseTemplate(response);

            $('#loggedin').show();
          }
      });
    } else {
        // render initial screen
        $('#loggedin').hide();
    }

    document.getElementById('obtain-new-token').addEventListener('click', function() {
      $.ajax({
        url: '/refresh_token',
        data: {
          'refresh_token': refresh_token
        }
      }).done(function(data) {
        access_token = data.access_token;
        refresh_token = data.refresh_token;
        oauthPlaceholder.innerHTML = oauthTemplate({
          access_token: access_token,
          refresh_token: refresh_token
        });
      });
    }, false);
  }
})();