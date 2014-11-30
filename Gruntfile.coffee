gruntConfig = (grunt) ->
  grunt.initConfig
    #Compile Coffeescript
    coffee:
      compile:
        expand: true
        cwd: "src/scripts/coffeescript"
        src: ["*.coffee"]
        dest: "build/scripts/javascript"
        ext: ".js"

    #Install Bower dependencies
    bower:
      install:
        options:
          copy: false

    #Compile Sass
    sass:
      compile:
        files: [
          expand: true
          cwd: "styles/sass"
          src: ["*.sass"]
          dest: "build/styles/css"
          ext: ".css"
        ]

    #Manifest Sync
    manifestSync:
      main:
        options:
          primaryManifest: "manifest.json"
          manifests:
            npm: "package.json"
            bower: "bower.json"
            chromeExtension:
              dest: "build/manifest.json"
              manifest_version: 2
              default_locale: "en"
              icon: "images/icon.png"
              background:
                persistent: true

    #Clean directories
    clean:
      javascript: ["build/scripts/javascript"]
      css: ["build/styles/css"]

    #Watch
    watch:
      coffeescript:
        files: "src/scripts/coffeescript/*.coffee"
        tasks: ["buildCoffeescript"]
      sass:
        files: "src/styles/sass/*.sass"
        tasks: ["buildSass"]
      manifest:
        files: "manifest.json"
        tasks: ["buildManifests"]

  #Load Grunt tasks
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-manifest-sync"

  #Register Grunt tasks
  grunt.registerTask "build", ["installBower", "buildCoffeescript"]

  grunt.registerTask "installBower", ["bower:install"]
  grunt.registerTask "buildCoffeescript", ["clean:javascript", "coffee:compile"]
  grunt.registerTask "buildSass", ["clean:css", "sass:compile"]
  grunt.registerTask "buildManifests", ["manifestSync:main"]

module.exports = gruntConfig
