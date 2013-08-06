//
//= require head.core.0.99.min
//= require jquery
//= require syntax_highlighter/shCore
//= require syntax_highlighter/shBrushBash
//= require syntax_highlighter/shBrushPython

$(function(){
    SyntaxHighlighter.defaults.gutter = false
    SyntaxHighlighter.all();
});
