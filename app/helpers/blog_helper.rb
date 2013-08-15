require 'rouge'

module BlogHelper
  include ERB::Util

  def compile(path, code_block_regex)
    raw = File.read(path)
    yaml = YAML.load(raw)
    erb = raw.gsub(/---(.|\n)*?---/, '')

    post = BlogPost.new(yaml)
    file_name = path.slice((path.rindex('/')+1)..(path.length-1))
    html = ERB.new(erb).result(post.instance_eval { binding })

    html.gsub!(code_block_regex) do
      syntax_highlight_block($1,$2)
    end

    post.file_name = file_name
    post.body = html_escape(html)
    post.categories = post.categories.join(',')
    post.md5_hash = post.md5()
    post
  end

  def syntax_highlight_block(lang, block)
      Rouge::Lexers.constants.each do |lexer_lang|
        formatter = Rouge::Formatters::HTML.new(:css_class => "highlight #{lexer_lang.downcase}")
        if lexer_lang.to_s.downcase == lang.strip.chomp.downcase
          unescaped = CGI.unescapeHTML(block)
          return formatter.format(Rouge::Lexers.const_get(lexer_lang).lex(unescaped))
        end
      end
  end
end
