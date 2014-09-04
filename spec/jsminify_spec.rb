require 'spec_helper'

describe(Jekyll::Converters::CoffeeScript) do
  let(:js_converter) do
    Jekyll::Converters::JSMinify.new
  end

  let(:cs_converter) do
    Jekyll::Converters::CSMinify.new
  end

  let(:cs_content) do
    <<-COFFEESCRIPT
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
  end
end
