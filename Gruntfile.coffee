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
          cwd: "src/styles/sass"
          src: ["**/*"]
          dest: "build/styles"
          ext: ".css"
        ]

    #Compile Haml
    haml:
      compile:
        files: [
          {
            expand: true
            cwd: "src/views/haml"
            src: "**/*"
            dest: "build/views"
            ext: ".html"
          }
          {
            expand: true
            cwd: "src/views/ember"
            src: "**/*"
            dest: "build/views/ember"
            ext: ".handlebars"
          }
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
      html: ["build/views"]
      images: ["build/images"]
      libs: ["build/libs"]

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
      libs:
        expand: true
        cwd: "libs"
        src: "**/*"
        dest: "build/libs"

    #Watch
    watch:
      javascript:
        files: "src/scripts/javascript/**/*"
        tasks: ["buildJavascript"]
      sass:
        files: "src/styles/sass/**/*"
        tasks: ["buildSass"]
      images:
        files: "src/images/**/*"
        tasks: ["buildImages"]
      manifest:
        files: "manifest.json"
        tasks: ["buildManifests"]
      haml:
        files: "src/views/haml/**/*"
        tasks: ["buildHaml"]
      libs:
        files: ["libs/**/*"]
        tasks: ["buildBower"]

  #Load Grunt tasks
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-manifest-sync"
  grunt.loadNpmTasks "grunt-haml"

  #Register Grunt tasks
  grunt.registerTask "build", ["buildJavascript", "buildSass", "buildManifests", "buildImages"]

  grunt.registerTask "installBower", ["bower:install", "buildBower"]
  grunt.registerTask "buildBower", ["clean:libs", "copy:libs"]
  grunt.registerTask "buildJavascript", ["clean:javascript", "copy:javascript"]
  grunt.registerTask "buildSass", ["clean:css", "sass:compile"]
  grunt.registerTask "buildManifests", ["manifestSync:main"]
  grunt.registerTask "buildImages", ["clean:images", "copy:images"]
  grunt.registerTask "buildHaml", ["clean:html", "haml:compile"]

module.exports = gruntConfig
