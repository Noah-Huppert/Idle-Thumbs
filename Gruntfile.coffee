gruntConfig = (grunt) ->
  grunt.initConfig
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

    #Clean directories
    clean:
      javascript: ["build/scripts/javascript"]
      css: ["build/styles/css"]

    #Copy files
    copy:
      javascript:
        expand: true
        cwd: "src/scripts/javascript"
        src: "**/*"
        dest: "build/scripts/javascript"
      images:
        expand: true
        cwd: "src/images"
        src: "**/*"
        dest: "build/images"

    #Watch
    watch:
      javascript:
        files: "src/scripts/javascript/*.js"
        tasks: ["buildJavascript"]
      sass:
        files: "src/styles/sass/*.sass"
        tasks: ["buildSass"]
      images:
        files: "src/images"
        tasks: ["buildImages"]
      manifest:
        files: "manifest.json"
        tasks: ["buildManifests"]

  #Load Grunt tasks
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-manifest-sync"

  #Register Grunt tasks
  grunt.registerTask "build", ["installBower", "buildCoffeescript"]

  grunt.registerTask "installBower", ["bower:install"]
  grunt.registerTask "buildJavascript", ["clean:javascript", "copy:javascript"]
  grunt.registerTask "buildSass", ["clean:css", "sass:compile"]
  grunt.registerTask "buildManifests", ["manifestSync:main"]
  grunt.registerTask "buildImages", ["copy:images"]

module.exports = gruntConfig
