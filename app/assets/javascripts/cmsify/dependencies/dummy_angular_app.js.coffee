angular.module('Cmsify',[])

app = angular.module("CmsifyApp",
  [
    'Cmsify'
  ]
)

app.config [
  '$httpProvider'
  ($httpProvider) ->
    $httpProvider.defaults.headers.common['Accept'] = "application/json"
    $httpProvider.defaults.headers.common['Content-Type'] = "application/json"
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  ]


$(document).on('ready page:load', ->
  angular.bootstrap("html", ['CmsifyApp'])
  console.log "go!!"
)