How to Create a Plugin
======================


This goal of this tutorial is to help users quickly and easily create Foreman plugins. This is not an exhaustive tutorial of [Ruby on Rails] or an explanation of how [rails engines] work.

Naming your plugin
------------------

It’s strongly recommended that your plugin begins with the string “foreman” to help people identify its relationship with the project. Plugins are published as gems to rubygems.org, so check that the name you wish to use is free - again, using a standard prefix helps. The prefix is also assumed in the installer, so makes adding support there easier.

Multiple words in the gem name should be separated with underscores (“\_”), although some plugins use underscores for the gem name and hyphens for git repo names. The git repo name isn’t as important, but it’s suggested to keep them to same to help people find it.

A good example is **foreman\_hooks** because the name clearly states it’s a foreman plugin that adds hooks.

Using the example plugin
------------------------

There is a fully working example plugin which you can clone to get you started. It contains examples of many of the types of behaviour that you might want to do in a plugin, such as adding new models, overriding views, extending controllers, adding permissions and menu items, and so on. The README contains a list of it’s current behaviour. To get started building your first Foreman Plugin run the following command:

    git clone https://github.com/theforeman/foreman_plugin_template my_plugin

A new directory my\_plugin is created for the plugin. Now go into this directory and use the rename script to change all references to ForemanPluginTemplate to MyPlugin:

    cd my_plugin; ./rename.rb my_plugin

Installing the plugin
---------------------

It’s best to test a plugin on a development installation of Foreman, as it loads code on the fly and doesn’t require building and installing your plugin as a gem. http://theforeman.org/contribute.html describes setting up a small test instance.

You can enable the plugin right away, and see what it’s default behaviour is, by editing foreman Gemfile.local.rb file (or creating this file under the folder bundler.d) and adding the following line

    # Gemfile.local.rb
    gem 'my_plugin', :path => 'path_to/my_plugin'

Install the ‘preface’ bundle by running

    bundle install

Restart (or start if it wasn’t up) foreman (type ‘rails server’) and the new foreman plugin should be listed in the about page plugin tab. If it isn’t, check your gem name and the symbol you passed to Foreman::Plugin.register match. Watch out for hyphens - e.g. gem ‘foreman-tasks’ would need to be registered as Foreman::Plugin.register :“foreman-tasks”.

Note that Debian or other “production” installations need to be restarted after code changes, as they won’t reload on the fly.

### RPM installations

RPM installations use bundler\_ext

  [Ruby on Rails]: http://rubyonrails.org/
  [rails engines]: http://guides.rubyonrails.org/engines.html
