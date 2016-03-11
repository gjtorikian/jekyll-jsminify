require 'spec_helper'

describe(Jekyll::Converters) do
  let(:js_converter) do
    Jekyll::Converters::JSMinify.new
  end

  let(:cs_converter) do
    Jekyll::Converters::CSMinify.new
  end

  let(:config) do
    {
      'jsminify' => {
        'output' => { 'comments' => 'none' }
      }
    }
  end

  let(:do_not_minify) do
    {
      'jsminify' => {
        'do_not_compress' => true
      }
    }
  end

  let(:js_converter_with_config) do
    Jekyll::Converters::JSMinify.new(config)
  end

  let(:cs_converter_with_config) do
    Jekyll::Converters::CSMinify.new(config)
  end

  let(:js_converter_with_no_minification) do
    Jekyll::Converters::JSMinify.new(do_not_minify)
  end

  let(:cs_converter_with_no_minification) do
    Jekyll::Converters::CSMinify.new(do_not_minify)
  end

  let(:cs_content) do
    <<-COFFEESCRIPT
###
# @file This is my cool script.
# @copyright Garen J. Torikian 2014
###
# Functions:
square = (x) -> x * x

# Arrays:
list = [1, 2, 3, 4, 5]

# Objects:
math =
  root:   Math.sqrt
  square: square
  cube:   (x) -> x * square x
COFFEESCRIPT
  end

  let(:js_content) do
    <<-JS
/*
 * @file This is my cool script.
 * @copyright Garen J. Torikian 2014
 */
(function() {
  var list, math, square;

  square = function(x) {
    return x * x;
  };

  list = [1, 2, 3, 4, 5];

  math = {
    root: Math.sqrt,
    square: square,
    cube: function(x) {
      return x * square(x);
    }
  };

}).call(this);
JS
  end

  let (:js_minified) do
    "/*\n * @file This is my cool script.\n * @copyright Garen J. Torikian 2014\n */\n(function(){var t,n,r;r=function(t){return t*t},t=[1,2,3,4,5],n={root:Math.sqrt,square:r,cube:function(t){return t*r(t)}}}).call(this);"
  end

  let (:js_do_not_minify) do
    "\n/*\n * @file This is my cool script.\n * @copyright Garen J. Torikian 2014\n */\n\n(function() {\n  var list, math, square;\n\n  square = function(x) {\n    return x * x;\n  };\n\n  list = [1, 2, 3, 4, 5];\n\n  math = {\n    root: Math.sqrt,\n    square: square,\n    cube: function(x) {\n      return x * square(x);\n    }\n  };\n\n}).call(this);\n"
  end

  let (:js_minified_no_comment) do
    "(function(){var t,n,r;r=function(t){return t*t},t=[1,2,3,4,5],n={root:Math.sqrt,square:r,cube:function(t){return t*r(t)}}}).call(this);"
  end

  context "matching file extensions" do
    it "matches .js files" do
      expect(js_converter.matches(".js")).to be(true)
    end

    it "matches .coffee files" do
      expect(cs_converter.matches(".coffee")).to be(true)
    end
  end

  context "determining the output file extension" do
    it "always outputs the .js file extension" do
      expect(js_converter.output_ext(".always-js-dont-matter")).to eql(".js")
    end

    it "always outputs the .coffee file extension" do
      expect(cs_converter.output_ext(".always-js-dont-matter")).to eql(".js")
    end
  end

  context "minification" do
    it "produces minified JS" do
      expect(js_converter.convert(js_content)).to eql(js_minified)
    end

    it "produces minified CS" do
      expect(cs_converter.convert(cs_content)).to eql(js_minified)
    end

    context "with config" do
      it "produces minified JS without comments" do
        expect(js_converter_with_config.convert(js_content)).to eql(js_minified_no_comment)
      end

      it "produces minified CS without comments" do
        expect(cs_converter_with_config.convert(cs_content)).to eql(js_minified_no_comment)
      end
    end
  end

  context "minify nothing" do
    it "does not produce minified JS when asked not to" do
      expect(js_converter_with_no_minification.convert(js_content)).to eql(js_content)
    end

    it "does not produce minified CS when asked not to" do
      expect(cs_converter_with_no_minification.convert(cs_content)).to eql(js_do_not_minify)
    end
  end
end
