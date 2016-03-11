# jekyll-jsminify

This is an absolute barebones JavaScript and CoffeeScript minifer for Jekyll. For something extraordinary that covers all use cases, I suggest [jekyll-assets](https://github.com/ixti/jekyll-assets).

## Installation

In your *_config.yml* file, add this gem:

``` yaml
gems:
  - jekyll-jsminify
```

## Usage

With Jekyll, you can fake out concatenation of multiple JavaScript/CoffeeScript files.

For example, if you have a file called *application.js* that looks like this:

```
---
---
{% include assets/javascripts/foo.js %}
{% include assets/javascripts/bar.js %}
{% include assets/javascripts/js.js %}
```

or a file called *application_cs.js* that looks like this:

```
---
---

$ = jQuery # this avoids load errors with CoffeeScript coming after jQuery

{% include assets/coffeescripts/foo.coffee %}
{% include assets/coffeescripts/bar.coffee %}
{% include assets/coffeescripts/cs.coffee %}
```

You'll create two files called *application.js* and *application_cs.js*, respectively, that contain the content of all our JS/CS assets.

Assuming you set your content up like that, this plugin will run [uglifier](https://github.com/lautis/uglifier) to compress the code.

You don't need to do anything special in your layouts; keep the same inclusion syntax is okay:

```html
<script src="{{ site.baseurl }}/assets/javascripts/application.js"></script>
<script src="{{ site.baseurl }}/assets/javascripts/application_cs.js"></script>
```

## Configuration

You can add the jsminify key to your *config.yml* file, and pass in any uglifer options you like:

``` yaml
jsminify:
     :mangle:
        :eval: true
```
