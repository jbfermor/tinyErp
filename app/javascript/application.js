// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require jquery
//= require popper
//= require bootstrap-sprockets
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

import "bootstrap"
import "@hotwired/turbo-rails"
import "controllers"

// app/javascript/packs/application.js
import { Turbo } from "@hotwired/turbo-rails"

// Add CSRF token to all Turbo requests
document.addEventListener('turbo:before-fetch-request', (event) => {
  const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
  event.detail.fetchOptions.headers['X-CSRF-Token'] = csrfToken
})

