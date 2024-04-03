module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    fontFamily: {
      'open-sans': ['Open Sans', 'sans-serif'],
      'dosis': ['Dosis', 'sans-serif'],
      'pacifico': ['Pacifico', 'cursive'], // Changed to 'cursive'
      'licorice': ['Licorice', 'cursive'], // Added Licorice font
    },
  }
}
